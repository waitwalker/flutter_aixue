import 'package:flutter/cupertino.dart';
import 'package:flutter_aixue/assistant/enum_assistant.dart';
import 'package:flutter_aixue/dao/dao.dart';
import 'package:flutter_aixue/models/login_model.dart';
import 'package:flutter_aixue/pages/teacher_app/teacher_home_page.dart';
import 'package:page_transition/page_transition.dart';


///
/// @name AppLoginManager
/// @description 登录管理
/// @author lca
/// @date 2019-10-25
///
class AppLoginManager {

  ///
  /// @name instance
  /// @description 单例模式
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-10-28
  ///
  factory AppLoginManager() => _getInstance();
  static AppLoginManager get instance => AppLoginManager._getInstance();
  static AppLoginManager _instance;
  AppLoginManager._internal() {
    // 初始化
  }
  static AppLoginManager _getInstance() {
    if (_instance == null) {
      _instance = new AppLoginManager._internal();
    }
    return _instance;
  }

  /// 登录 model
  Data loginModel;

  routeToPage(BuildContext context, Map<String,dynamic> parameters, ETTLoginType type) async {
    var response = await DaoManager.loginFetch(parameters);
    if (response.result && response.model != null) {
      AppLoginManager.instance.loginModel = response.model;
      
    } else {
      print("登录异常,请稍候重试");
    }
    print(response);
  }

  static login(String account, String password, ETTLoginType loginType) {

  }

}