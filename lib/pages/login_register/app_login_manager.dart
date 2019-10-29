import 'package:flare_loading/flare_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aixue/assistant/enum_assistant.dart';
import 'package:flutter_aixue/dao/dao.dart';
import 'package:flutter_aixue/models/login_model.dart';
import 'package:flutter_aixue/pages/student_app/student_home_page.dart';
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

  ///
  /// @name routeToPage
  /// @description 登录后的路由页
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-10-29
  ///
  routeToPage(BuildContext context, Map<String,dynamic> parameters) async {
    /// 显示加载圈
    showLoading(context);
    var response = await DaoManager.loginFetch(parameters);
    if (response.result && response.model != null) {
      AppLoginManager.instance.loginModel = response.model.data;
      Navigator.of(context).pop();
      _enterToApp(context, response.model.data);
    } else {
      print("登录异常,请稍候重试");
    }
    print(response);
  }

  ///
  /// @name _enterToApp
  /// @description 进入app
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-10-29
  ///
  _enterToApp(BuildContext context,Data model) {
    if (model.uType == 1 || model.uType == 2) {
      /// 教师
      Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: TeacherHomePage()));
    } else if (model.uType == 3 || model.uType == 4) {
      /// 学生
      Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: StudentHomePage()));
    } else if (model.uType == 5 || model.uType == 5) {
      /// 家长
      Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: TeacherHomePage()));
    }
  }

  showLoading(BuildContext context) {
    showDialog(context: context,builder: (context) {
      return Center(
        child: Container(
          width: 80,
          height: 80,
          child: CircularProgressIndicator(),
        ),
      );
    });
  }



  static login(String account, String password, ETTLoginType loginType) {

  }

}