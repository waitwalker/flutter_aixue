//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_aixue/common/database/database_manager.dart';
//import 'package:flutter_aixue/common/locale/localizations_delegate.dart';
//import 'package:flutter_aixue/common/redux/app_state.dart';
//import 'package:flutter_aixue/common/theme/theme_manager.dart';
//import 'package:flutter_aixue/pages/placeholder_page/placeholder_page.dart';
//import 'package:flutter_aixue/pages/student_app/student_home_page.dart';
//import 'package:flutter_aixue/pages/teacher_app/teacher_home_page.dart';
//import 'package:flutter_aixue/pages/login_register/app_login_page.dart';
//import 'package:flutter_aixue/pages/launch/splash_page.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:flutter_redux/flutter_redux.dart';
//import 'package:redux/redux.dart';
//
//
//void main() {
//  WidgetsFlutterBinding.ensureInitialized();
//  DataBaseManager.instance.initDatabase();
//  runApp(App());
//}
//
///// 主要入口
//class App extends StatelessWidget {
//  final store = Store<AppState>(
//    appReducer,
//    initialState: AppState(
//        theme: ThemeManager.defaultTheme(),
//        locale: Locale("zh","CH")
//    ),
//  );
//
//  @override
//  Widget build(BuildContext context) {
//    return StoreProvider(
//      store: store,
//      child: StoreBuilder<AppState>(builder: (context,store){
//        //store.state.platformLocale = Localizations.localeOf(context);
//        return MaterialApp(
//          debugShowCheckedModeBanner: false, /// 去掉debug标签
//          debugShowMaterialGrid: false,
//          localizationsDelegates: <LocalizationsDelegate<dynamic>>[
//            GlobalMaterialLocalizations.delegate,
//            GlobalWidgetsLocalizations.delegate,
//            MTTLocalizationsDelegate.delegate,
//            ChineseCupertinoLocalizations.delegate, // 自定义的delegate
//
//            DefaultCupertinoLocalizations.delegate, // 目前只包含英文
//          ],
//          locale: store.state.locale,
//          supportedLocales: [store.state.locale,Locale('zh', 'Hans'),],
//          theme: store.state.theme.themeData,
//          home: MTTLocalizations(child: SplashPage(),),
//          routes: <String, WidgetBuilder>{
//            "/splash": (BuildContext context) => SplashPage(),
//            "/login": (BuildContext context) => AppLoginPage(),
//            "/teacher_home": (BuildContext context) => TeacherHomePage(),
//            "/student_home": (BuildContext context) => StudentHomePage(),
//          },
//          onUnknownRoute: (RouteSettings setting) {
//            String name = setting.name;
//            print("onUnknownRoute:$name");
//            return MaterialPageRoute(builder: (context) {
//              return PlaceholderPage();
//            });
//          },
//        );
//      }),
//    );
//  }
//}
//
//
//class MTTLocalizations extends StatefulWidget {
//  final Widget child;
//
//  MTTLocalizations({Key key, this.child}) : super(key: key);
//
//  @override
//  State<MTTLocalizations> createState() {
//    return _LocalizationsState();
//  }
//}
//
//class _LocalizationsState extends State<MTTLocalizations> {
//
//  @override
//  Widget build(BuildContext context) {
//    return StoreBuilder<AppState>(builder: (context, store) {
//      ///通过 StoreBuilder 和 Localizations 实现实时多语言切换
//      return Localizations.override(
//        context: context,
//        locale: store.state.locale,
//        child: widget.child,
//      );
//    });
//  }
//
//  @override
//  void initState() {
//    super.initState();
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//  }
//}

import 'package:flutter/material.dart';
// import 'mock/list.dart' as newsList;

const TITLE = '标题标题标题标题标题标题标题';
const SUB_TITLE = '二级标题二级标题二级标题二级标题二级标题二级标题二级标题二级标题二';
const IMAGE_SRC =
    'http://cms-bucket.ws.126.net/2019/06/20/68fa7f186ffe4479ab27efabd4d94246.png';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('TabController'),
          backgroundColor: Colors.pink,
        ),
        body: TabControllerDemo(),
      ),
    );
  }
}

class TabControllerDemo extends StatefulWidget {
  TabControllerDemo({Key key}) : super(key: key);

  _TabControllerDemoState createState() => _TabControllerDemoState();
}

class _TabControllerDemoState extends State<TabControllerDemo>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    this._tabController = new TabController(vsync: this, length: 5);
    this._tabController.addListener(() {
      print(this._tabController.toString());
      print(this._tabController.index);
      print(this._tabController.length);
      print(this._tabController.previousIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: TabBar(
            controller: this._tabController,
            tabs: <Widget>[
              Tab(text: '女装'),
              Tab(text: '男装'),
              Tab(text: '童装'),
              Tab(text: '夏装'),
              Tab(text: '冬装'),
            ],
          ),
        ),
        body: TabBarView(
          controller: this._tabController,
          children: <Widget>[
            ListViewContnet(),
            ListViewContnet(),
            ListViewContnet(),
            ListViewContnet(),
            ListViewContnet(),
          ],
        ));
  }
}

class ListViewContnet extends StatelessWidget {
  const ListViewContnet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(title: Text(TITLE)),
        ListTile(title: Text(TITLE)),
        ListTile(title: Text(TITLE)),
        ListTile(title: Text(TITLE)),
        ListTile(title: Text(TITLE)),
        ListTile(title: Text(TITLE)),
        ListTile(title: Text(TITLE)),
        ListTile(title: Text(TITLE)),
        ListTile(title: Text(TITLE)),
        ListTile(title: Text(TITLE)),
      ],
    );
  }
}

/**
 *
 *
 * import 'package:flutter/material.dart';
    // import 'mock/list.dart' as newsList;

    const TITLE = '标题标题标题标题标题标题标题';
    const SUB_TITLE = '二级标题二级标题二级标题二级标题二级标题二级标题二级标题二级标题二';
    const IMAGE_SRC =
    'http://cms-bucket.ws.126.net/2019/06/20/68fa7f186ffe4479ab27efabd4d94246.png';

    void main() {
    runApp(MyApp());
    }

    class MyApp extends StatelessWidget {
    MyApp({Key key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
    return MaterialApp(
    home: Scaffold(
    appBar: AppBar(
    title: Text('TabController'),
    backgroundColor: Colors.pink,
    ),
    body: TabControllerDemo(),
    ),
    );
    }
    }

    class TabControllerDemo extends StatefulWidget {
    TabControllerDemo({Key key}) : super(key: key);

    _TabControllerDemoState createState() => _TabControllerDemoState();
    }

    class _TabControllerDemoState extends State<TabControllerDemo>
    with SingleTickerProviderStateMixin {
    TabController _tabController;

    @override
    void initState() {
    super.initState();
    this._tabController = new TabController(vsync: this, length: 5);
    this._tabController.addListener(() {
    print(this._tabController.toString());
    print(this._tabController.index);
    print(this._tabController.length);
    print(this._tabController.previousIndex);
    });
    }

    @override
    Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
    backgroundColor: Colors.black,
    title: TabBar(
    controller: this._tabController,
    tabs: <Widget>[
    Tab(text: '女装'),
    Tab(text: '男装'),
    Tab(text: '童装'),
    Tab(text: '夏装'),
    Tab(text: '冬装'),
    ],
    ),
    ),
    body: TabBarView(
    controller: this._tabController,
    children: <Widget>[
    ListViewContnet(),
    ListViewContnet(),
    ListViewContnet(),
    ListViewContnet(),
    ListViewContnet(),
    ],
    ));
    }
    }

    class ListViewContnet extends StatelessWidget {
    const ListViewContnet({Key key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
    return ListView(
    children: <Widget>[
    ListTile(title: Text(TITLE)),
    ListTile(title: Text(TITLE)),
    ListTile(title: Text(TITLE)),
    ListTile(title: Text(TITLE)),
    ListTile(title: Text(TITLE)),
    ListTile(title: Text(TITLE)),
    ListTile(title: Text(TITLE)),
    ListTile(title: Text(TITLE)),
    ListTile(title: Text(TITLE)),
    ListTile(title: Text(TITLE)),
    ],
    );
    }
    }
 * */

