import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aixue/common/locale/locale_mamager.dart';
import 'package:flutter_aixue/common/redux/app_state.dart';
import 'package:flutter_aixue/common/theme/theme_manager.dart';
import 'package:flutter_aixue/main.dart';
import 'package:flutter_aixue/pages/login_register/app_login_manager.dart';
import 'package:flutter_aixue/pages/login_register/app_login_page.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

///
/// @Class: SplashPage
/// @Description: 启动动画页
/// @author: lca
/// @Date: 2019-08-06
///
class SplashPage extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  int themeIndex = 0;
  int localeIndex = 0;

  AnimationController animationController;
  Animation<double> animation;

  startTime() async {
    var _duration = Duration(milliseconds: 1500);
    return Timer(_duration, navigationPage);
  }

  /// 读取本地缓存数据
  readLocalCacheData() async {
    Store<AppState> store = StoreProvider.of(context);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    /// 获取主题
    themeIndex = sharedPreferences.getInt("theme");
    if (themeIndex == null) {
      themeIndex = 0;
    }
    ThemeManager.pushTheme(store, themeIndex);

    /// 获取语言
    localeIndex = sharedPreferences.getInt("locale");

    if (localeIndex == null) {
      localeIndex = 0;
    }
    LocaleManager.changeLocale(store, localeIndex);
  }

  void navigationPage() async {
    await AppLoginManager.instance.autoLogin(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    readLocalCacheData();
  }

  @override
  void dispose() {
    if (animationController != null) {
      animationController.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion(child: Container(
        color: Colors.white,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                Padding(
                    padding: EdgeInsets.only(bottom: 30.0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 32,
                      width: 200,
                      child: Text(
                        "Powed by waitwalker.cn",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Color.fromRGBO(0, 0, 0, 0.6)),
                      ),
                      decoration: BoxDecoration(
                          boxShadow: [BoxShadow(color: Colors.blue,offset: Offset(-2, 2),blurRadius: 2)],
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white
                      ),
                    )
                )

              ],),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'lib/resources/images/1024.png',
                  width: animation.value * 300,
                  height: animation.value * 300,
                ),
              ],
            ),
          ],
        ),
      ), value: SystemUiOverlayStyle.light),
    );
  }
}
