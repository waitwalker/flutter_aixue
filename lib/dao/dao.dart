
import 'dart:convert';

import 'package:flutter_aixue/common/network/network_manager.dart';
import 'package:flutter_aixue/models/login_model.dart';

class LoginDAO {

  static Future <ResponseData> fetch(Map<String,dynamic> parameters) async {
    var response = await NetworkManager.post(Const.loginInterface, parameters);
    if (response.result) {
      Utf8Decoder utf8decoder = Utf8Decoder();//修复中文乱码问题
      print("response.data:${response.data}");

      String jsonString = response.data;

      var resultMap = json.decode(jsonString);
      var loginModel = LoginModel.fromJson(resultMap);
        response.model = loginModel;
        return response;
    } else {
      throw Exception("登录接口请求失败");
    }
  }
}
