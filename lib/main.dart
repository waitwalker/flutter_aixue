import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aixue/common/locale/localizations_delegate.dart';
import 'package:flutter_aixue/common/redux/app_state.dart';
import 'package:flutter_aixue/common/theme/theme_manager.dart';
import 'package:flutter_aixue/pages/login_page.dart';
import 'package:flutter_aixue/pages/splash_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}


class App extends StatelessWidget {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState(
        theme: ThemeManager.defaultTheme(),
        locale: Locale("zh","CH")
    ),
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: StoreBuilder<AppState>(builder: (context,store){
        //store.state.platformLocale = Localizations.localeOf(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false, /// 去掉debug标签
          debugShowMaterialGrid: false,
          localizationsDelegates: <LocalizationsDelegate<dynamic>>[
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            MTTLocalizationsDelegate.delegate,
            ChineseCupertinoLocalizations.delegate, // 自定义的delegate

            DefaultCupertinoLocalizations.delegate, // 目前只包含英文
          ],
          locale: store.state.locale,
          supportedLocales: [store.state.locale,Locale('zh', 'Hans'),],
          theme: store.state.theme.themeData,
          home: MTTLocalizations(child: AnimatedSplashScreen(),),
          routes: <String, WidgetBuilder>{
            "login": (BuildContext context) => LoginPage(),
          },
        );
      }),
    );
  }
}

class MTTLocalizations extends StatefulWidget {
  final Widget child;

  MTTLocalizations({Key key, this.child}) : super(key: key);

  @override
  State<MTTLocalizations> createState() {
    return _LocalizationsState();
  }
}

class _LocalizationsState extends State<MTTLocalizations> {

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(builder: (context, store) {
      ///通过 StoreBuilder 和 Localizations 实现实时多语言切换
      return Localizations.override(
        context: context,
        locale: store.state.locale,
        child: widget.child,
      );
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

