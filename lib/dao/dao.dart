
import 'package:flutter_aixue/common/network/network_manager.dart';
import 'package:flutter_aixue/models/login_model.dart';

class LoginDAO {

  static Future <ResponseData> fetch(Map parameters) async {
    var response = NetworkManager.post(Const.loginInterface, parameters);
    if (response.result) {
      var loginModel = LoginModel.fromJson(response.data);
        response.model = loginModel;
        return response;
    } else {
      throw Exception("登录接口请求失败");
    }
  }
}
