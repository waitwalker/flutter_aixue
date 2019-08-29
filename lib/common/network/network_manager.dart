import 'dart:collection';
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:io';
import 'package:event_bus/event_bus.dart';
import 'package:flutter_aixue/common/config/config.dart';

///
/// @Class: NetworkManager
/// @Description: 网络请求管理类
/// @author: lca
/// @Date: 2019-08-01
///
class NetworkManager {

  static String _baseUrl;
  static const Accept_ContentType_JSON = "application/json";
  static const Accept_ContentType_Form = "application/x-www-form-urlencoded";
  static Map optionParameters = {
    "timeoutMs": 15000,
    "token": null,
    "authorizationCode": null,
  };


  static setBaseUrl(String baseUrl){
    _baseUrl = baseUrl;
  }

  ///
  /// @Method: get
  /// @Parameter: url parameters
  /// @ReturnType: Future<ResponseData>
  /// @Description: get 方法
  /// @author: lca
  /// @Date: 2019-08-01
  ///
  static get(url,parameters) async{
    return await fetch(_baseUrl+url, parameters, null, Options(method:"GET"));
  }

  ///
  /// @Method: post
  /// @Parameter: url parameters
  /// @ReturnType: Future<ResponseData>
  /// @Description: put 方法
  /// @author: lca
  /// @Date: 2019-08-01
  ///
  static post(interface,parameters) async{
    return await fetch(interface, parameters, {"Accept": 'application/vnd.github.VERSION.full+json'}, Options(method: 'POST'));
  }

  ///
  /// @Method: delete
  /// @Parameter: url parameters
  /// @ReturnType: Future<ResponseData>
  /// @Description: delete 方法
  /// @author: lca
  /// @Date: 2019-08-01
  ///
  static delete(url,parameters) async{
    return await fetch(_baseUrl+url, parameters, null, Options(method: 'DELETE'));
  }

  ///
  /// @Method: put
  /// @Parameter: url parameters
  /// @ReturnType: Future<ResponseData>
  /// @Description: put 方法
  /// @author: lca
  /// @Date: 2019-08-01
  ///
  static put(url,parameters) async{
    return await fetch(_baseUrl+url, parameters, null, Options(method: "PUT", contentType: ContentType.text));
  }

  
  ///
  /// @Method: fetch
  /// @Parameter:
  /// @ReturnType:
  /// @Description:
  /// @author: lca
  /// @Date: 2019-08-01
  ///
  static fetch(interface, parameters, Map<String, String> header, Options option, {noTip = false}) async {

    /// 没有网络
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return ResponseData(StatusCode.errorHandleFunction(StatusCode.Network_Error, "", noTip), false, StatusCode.Network_Error);
    }

    Map<String, String> headers = HashMap();
    if (header != null) {
      headers.addAll(header);
    }


    /// 授权码
    if (optionParameters["authorizationCode"] == null) {
      var authorizationCode = await getAuthorization();
      if (authorizationCode != null) {
        optionParameters["authorizationCode"] = authorizationCode;
      }
    }

    headers["Authorization"] = optionParameters["authorizationCode"];
    headers["client"] = Platform.isIOS ? "iOS" : "android";

    /// 设置请求options
    if (option != null) {
      option.headers = headers;
    } else{
      /// 默认
      option = Options(method: "get");
      option.headers = headers;
    }

    /// 超时时间
    option.connectTimeout = 15000;

    Map<String,dynamic> tmpParameters = parameters;
    tmpParameters["time"] = NetworkAssistant.currentTimeMilliseconds().toString();
    String sign = NetworkAssistant.getSign(tmpParameters, interface);
    tmpParameters["sign"] = sign;
    String url = NetworkAssistant.getUrl(interface);


    Dio dio = Dio();

    /// 添加拦截器
    if (Config.DEBUG) {
      dio.interceptors.add(InterceptorsWrapper(
          onRequest: (RequestOptions options){
            print("\n================== 请求数据 ==========================");
            print("url = ${options.uri.toString()}");
            print("headers = ${options.headers}");
            print("parameterss = ${options.data}");
          },
          onResponse: (Response response){
            print("\n================== 响应数据 ==========================");
            print("code = ${response.statusCode}");
            print("data = ${response.data}");
            print("\n");
          },
          onError: (DioError e){
            print("\n================== 错误响应数据 ======================");
            print("type = ${e.type}");
            print("message = ${e.message}");
            print("stackTrace = ${e.stackTrace}");
            print("\n");
          }
      ));
    }

    /// 处理响应数据
    Response response;
    try {
      response = await dio.request(url, queryParameters: tmpParameters, options: option);
    } on DioError catch (e) {

      /// 请求错误处理
      Response errorResponse;

      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = Response(statusCode: StatusCode.Network_Error_Unknown);
      }

      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        errorResponse.statusCode = StatusCode.Network_Timeout;
      }

      if (Config.DEBUG) {
        print('请求异常: ' + e.toString());
        print('请求异常 url: ' + url);
      }

      return ResponseData(StatusCode.errorHandleFunction(errorResponse.statusCode, e.message, noTip), false, errorResponse.statusCode);
    }

    /// 数据转换处理
    try {
      if (option.contentType != null && option.contentType.primaryType == "text") {
        return ResponseData(response.data, true, StatusCode.Success);
      } else {
        var responseJson = response.data;
        if (response.statusCode == 201 && responseJson["token"] != null) {
          optionParameters["authorizationCode"] = 'token ' + responseJson["token"];
          //await SpUtils.save(Config.TOKEN_KEY, optionParameters["authorizationCode"]);
        }
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ResponseData(response.data, true, StatusCode.Success, headers: response.headers);
      }
    } catch (e) {
      print(e.toString() + url);
      return ResponseData(response.data, false, response.statusCode, headers: response.headers);
    }
    return ResponseData(StatusCode.errorHandleFunction(response.statusCode, "", noTip), false, response.statusCode);
  }

  ///清除授权
  static clearAuthorization() {
//    optionparameterss["authorizationCode"] = null;
//    SpUtils.remove(Config.TOKEN_KEY);
  }

  ///
  /// @Method: getAuthorization
  /// @Parameter:
  /// @ReturnType:
  /// @Description: 获取token
  /// @author: lca
  /// @Date: 2019-08-01
  ///
  static getAuthorization() async {
//    String token = await SpUtils.get(Config.TOKEN_KEY);
//    if (token == null) {
//      String basic = await SpUtils.get(Config.USER_BASIC_CODE);
//      if (basic == null) {
//        //提示输入账号密码
//      } else {
//        //通过 basic 去获取token，获取到设置，返回token
//        return "Basic $basic";
//      }
//    } else {
//      optionparameterss["authorizationCode"] = token;
//      return token;
//    }
  }

}

 ///
 /// @Class: ResponseData
 /// @Description: 响应结果类
 /// @author: lca
 /// @Date: 2019-08-01
 ///
class ResponseData {
  var data;
  bool result;
  int code;
  var headers;
  var model;
  
  ResponseData(this.data, this.result, this.code, {this.headers,this.model});
}

///
/// @Class: StatusCode
/// @Description: 响应状态码处理类
/// @author: lca
/// @Date: 2019-08-01
///
class StatusCode {

  /// 网络错误
  static const Network_Error = -601;

  /// 网络超时
  static const Network_Timeout = -602;

  /// 未知错误
  static const Network_Error_Unknown = -603;

  ///网络返回数据格式化一次
  static const Network_JSON_Exception = -3;

  /// 请求成功
  static const Success = 200;

  static final EventBus eventBus = new EventBus();

  static errorHandleFunction(code, message, noTip) {
    if(noTip) {
      return message;
    }
    eventBus.fire(new HttpErrorEvent(code, message));
    return message;
  }
}

class HttpErrorEvent {
  final int code;
  final String message;

  HttpErrorEvent(this.code, this.message);
}

class Const {
  static const String loginInterface = "login.do";
}

class NetworkAssistant {

  static int currentTimeMilliseconds() {
    return 111222333;//DateTime.now().millisecondsSinceEpoch;
  }

  static String getSign(Map parameter, String interface) {
    List<String> allKeys = [];
    parameter.forEach((key,value){
      allKeys.add(key);
    });

    allKeys.sort((obj1,obj2){
      return obj1.compareTo(obj2);
    });
    
    List<String> pairs = [];
    
    allKeys.forEach((key){
      pairs.add("$key=${parameter[key]}");
    });

    String pairsString = pairs.join("&");
    String sign = interface + "&" + pairsString + "*ETT#HONER#2014*";
    String md5 = generateMd5(sign);
    Base64Codec base64 = Base64Codec();
    String signString = base64.encoder.convert(md5.codeUnits);
    signString = signString.replaceAll("=", "");
    print("sign:$signString");
    return signString;
  }

  static String generateMd5(String string) {
    var content = Utf8Encoder().convert(string);
    var digest = md5.convert(content);
    // 这里其实就是 digest.toString()
    return hex.encode(digest.bytes);
  }

  static String getUrl(String interface) {
    switch (interface) {
      case Const.loginInterface:
        return "http://192.168.10.172:8080/user/login.do";
        break;
      default:
        return "";
        break;
    }
  }
}
