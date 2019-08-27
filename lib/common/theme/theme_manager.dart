import 'package:flutter/material.dart';
import 'package:flutter_aixue/common/redux/theme_data_reducer.dart';
import 'package:redux/redux.dart';
import 'mtt_theme.dart';

///颜色
class MTTColors {
  static const String primaryValueString = "#24292E";
  static const String primaryLightValueString = "#42464b";
  static const String primaryDarkValueString = "#121917";
  static const String miWhiteString = "#ececec";
  static const String actionBlueString = "#267aff";
  static const String webDraculaBackgroundColorString = "#282a36";

  static const int primaryValue = 0xFF24292E;
  static const int primaryLightValue = 0xFF42464b;
  static const int primaryDarkValue = 0xFF121917;

  static const int cardWhite = 0xFFFFFFFF;
  static const int textWhite = 0xFFFFFFFF;
  static const int miWhite = 0xffececec;
  static const int white = 0xFFFFFFFF;
  static const int actionBlue = 0xff267aff;
  static const int subTextColor = 0xff959595;
  static const int subLightTextColor = 0xffc4c4c4;

  static const int mainBackgroundColor = miWhite;
  static const int mainTextColor = primaryDarkValue;
  static const int textColorWhite = white;

  static const MaterialColor primarySwatch = const MaterialColor(
    primaryValue,
    const <int, Color>{
      50: const Color(primaryLightValue),
      100: const Color(primaryLightValue),
      200: const Color(primaryLightValue),
      300: const Color(primaryLightValue),
      400: const Color(primaryLightValue),
      500: const Color(primaryValue),
      600: const Color(primaryDarkValue),
      700: const Color(primaryDarkValue),
      800: const Color(primaryDarkValue),
      900: const Color(primaryDarkValue),
    },
  );
}

///
/// @Class: ThemeManager
/// @Description: 主题管理类 切换主题等功能
/// @author: lca
/// @Date: 2019-08-01
///
class ThemeManager {

  static getTheme(int index) {
    List<MTTTheme> themeList = [
      MTTTheme(
          textColor: Colors.black,
          homeIconContainerColor: Colors.black,
          homeIconColor: Colors.white,
          homeMenuColor: Colors.black,
          themeData: ThemeData(primaryColor: Colors.orange)
      ),

      MTTTheme(
          textColor: Colors.yellow,
          homeIconContainerColor: Colors.black,
          homeIconColor: Colors.yellow,
          homeMenuColor: Colors.yellow,
          themeData: ThemeData(primaryColor: Colors.green)
      ),

      MTTTheme(
          textColor: Colors.red,
          homeIconContainerColor: Colors.black,
          homeIconColor: Colors.red,
          homeMenuColor: Colors.red,
          themeData: ThemeData(primaryColor: Colors.cyan)
      ),

      MTTTheme(
          textColor: Colors.blue,
          homeIconContainerColor: Colors.black,
          homeIconColor: Colors.blue,
          homeMenuColor: Colors.blue,
          themeData: ThemeData(primaryColor: Colors.purple)
      ),

      MTTTheme(
          textColor: Colors.deepPurple,
          homeIconContainerColor: Colors.black,
          homeIconColor: Colors.deepPurple,
          homeMenuColor: Colors.deepPurple,
          themeData: ThemeData(primaryColor: Colors.lightGreenAccent)
      ),

      MTTTheme(
          textColor: Colors.cyan,
          homeIconContainerColor: Colors.black,
          homeIconColor: Colors.cyan,
          homeMenuColor: Colors.cyan,
          themeData: ThemeData(primaryColor: Colors.brown)
      ),
    ];
    return themeList[index];
  }

  ///
  /// @Method: pushTheme
  /// @Parameter: store index
  /// @ReturnType:
  /// @Description: 更换主题
  /// @author: lca
  /// @Date: 2019-08-01
  ///
  static pushTheme(Store store, int index) {
    MTTTheme theme = getTheme(index);
    store.dispatch(new RefreshThemeDataAction(theme));
  }

  static getThemeData(Color color) {
    return ThemeData(primarySwatch: color);
  }

  static defaultTheme() {
    return MTTTheme(
        textColor: Colors.yellow,
        homeIconContainerColor: Colors.black,
        homeIconColor: Colors.yellow,
        homeMenuColor: Colors.yellow,
        themeData: ThemeData(primaryColor: Colors.white)
    );
  }
}
