import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aixue/common/locale/localizations_delegate.dart';
import 'package:flutter_aixue/common/redux/app_state.dart';
import 'package:flutter_aixue/common/theme/theme_manager.dart';
import 'package:flutter_aixue/pages/teacher_app/teacher_home_page.dart';
import 'package:flutter_aixue/pages/login_register/app_login_page.dart';
import 'package:flutter_aixue/pages/launch/splash_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';




//import 'dart:async';
//import 'dart:convert';
//import 'package:flutter/material.dart';
//import 'package:webview_flutter/webview_flutter.dart';
//
//void main() => runApp(MaterialApp(home: WebViewExample()));
//
//const String kNavigationExamplePage = '''
//<!DOCTYPE html><html>
//<head><title>Navigation Delegate Example</title></head>
//<body>
//<p>
//The navigation delegate is set to block navigation to the youtube website.
//</p>
//<ul>
//<ul><a href="https://www.youtube.com/">https://www.youtube.com/</a></ul>
//<ul><a href="https://www.google.com/">https://www.google.com/</a></ul>
//</ul>
//</body>
//</html>
//''';
//
//class WebViewExample extends StatefulWidget {
//  @override
//  _WebViewExampleState createState() => _WebViewExampleState();
//}
//
//class _WebViewExampleState extends State<WebViewExample> {
//  final Completer<WebViewController> _controller =
//  Completer<WebViewController>();
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: const Text('Flutter WebView example'),
//        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
//        actions: <Widget>[
//          NavigationControls(_controller.future),
//          SampleMenu(_controller.future),
//        ],
//      ),
//      // We're using a Builder here so we have a context that is below the Scaffold
//      // to allow calling Scaffold.of(context) so we can show a snackbar.
//      body: Builder(builder: (BuildContext context) {
//        return WebView(
//          initialUrl: 'https://flutter.dev',
//          javascriptMode: JavascriptMode.unrestricted,
//          onWebViewCreated: (WebViewController webViewController) {
//            _controller.complete(webViewController);
//          },
//          // TODO(iskakaushik): Remove this when collection literals makes it to stable.
//          // ignore: prefer_collection_literals
//          javascriptChannels: <JavascriptChannel>[
//            _toasterJavascriptChannel(context),
//          ].toSet(),
//          navigationDelegate: (NavigationRequest request) {
//            if (request.url.startsWith('https://www.youtube.com/')) {
//              print('blocking navigation to $request}');
//              return NavigationDecision.prevent;
//            }
//            print('allowing navigation to $request');
//            return NavigationDecision.navigate;
//          },
//          onPageFinished: (String url) {
//            print('Page finished loading: $url');
//          },
//        );
//      }),
//      floatingActionButton: favoriteButton(),
//    );
//  }
//
//  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
//    return JavascriptChannel(
//        name: 'Toaster',
//        onMessageReceived: (JavascriptMessage message) {
//          Scaffold.of(context).showSnackBar(
//            SnackBar(content: Text(message.message)),
//          );
//        });
//  }
//
//  Widget favoriteButton() {
//    return FutureBuilder<WebViewController>(
//        future: _controller.future,
//        builder: (BuildContext context,
//            AsyncSnapshot<WebViewController> controller) {
//          if (controller.hasData) {
//            return FloatingActionButton(
//              onPressed: () async {
//                final String url = await controller.data.currentUrl();
//                Scaffold.of(context).showSnackBar(
//                  SnackBar(content: Text('Favorited $url')),
//                );
//              },
//              child: const Icon(Icons.favorite),
//            );
//          }
//          return Container();
//        });
//  }
//}
//
//enum MenuOptions {
//  showUserAgent,
//  listCookies,
//  clearCookies,
//  addToCache,
//  listCache,
//  clearCache,
//  navigationDelegate,
//}
//
//class SampleMenu extends StatelessWidget {
//  SampleMenu(this.controller);
//
//  final Future<WebViewController> controller;
//  final CookieManager cookieManager = CookieManager();
//
//  @override
//  Widget build(BuildContext context) {
//    return FutureBuilder<WebViewController>(
//      future: controller,
//      builder:
//          (BuildContext context, AsyncSnapshot<WebViewController> controller) {
//        return PopupMenuButton<MenuOptions>(
//          onSelected: (MenuOptions value) {
//            switch (value) {
//              case MenuOptions.showUserAgent:
//                _onShowUserAgent(controller.data, context);
//                break;
//              case MenuOptions.listCookies:
//                _onListCookies(controller.data, context);
//                break;
//              case MenuOptions.clearCookies:
//                _onClearCookies(context);
//                break;
//              case MenuOptions.addToCache:
//                _onAddToCache(controller.data, context);
//                break;
//              case MenuOptions.listCache:
//                _onListCache(controller.data, context);
//                break;
//              case MenuOptions.clearCache:
//                _onClearCache(controller.data, context);
//                break;
//              case MenuOptions.navigationDelegate:
//                _onNavigationDelegateExample(controller.data, context);
//                break;
//            }
//          },
//          itemBuilder: (BuildContext context) => <PopupMenuItem<MenuOptions>>[
//            PopupMenuItem<MenuOptions>(
//              value: MenuOptions.showUserAgent,
//              child: const Text('Show user agent'),
//              enabled: controller.hasData,
//            ),
//            const PopupMenuItem<MenuOptions>(
//              value: MenuOptions.listCookies,
//              child: Text('List cookies'),
//            ),
//            const PopupMenuItem<MenuOptions>(
//              value: MenuOptions.clearCookies,
//              child: Text('Clear cookies'),
//            ),
//            const PopupMenuItem<MenuOptions>(
//              value: MenuOptions.addToCache,
//              child: Text('Add to cache'),
//            ),
//            const PopupMenuItem<MenuOptions>(
//              value: MenuOptions.listCache,
//              child: Text('List cache'),
//            ),
//            const PopupMenuItem<MenuOptions>(
//              value: MenuOptions.clearCache,
//              child: Text('Clear cache'),
//            ),
//            const PopupMenuItem<MenuOptions>(
//              value: MenuOptions.navigationDelegate,
//              child: Text('Navigation Delegate example'),
//            ),
//          ],
//        );
//      },
//    );
//  }
//
//  void _onShowUserAgent(
//      WebViewController controller, BuildContext context) async {
//    // Send a message with the user agent string to the Toaster JavaScript channel we registered
//    // with the WebView.
//    controller.evaluateJavascript(
//        'Toaster.postMessage("User Agent: " + navigator.userAgent);');
//  }
//
//  void _onListCookies(
//      WebViewController controller, BuildContext context) async {
//    final String cookies =
//    await controller.evaluateJavascript('document.cookie');
//    Scaffold.of(context).showSnackBar(SnackBar(
//      content: Column(
//        mainAxisAlignment: MainAxisAlignment.end,
//        mainAxisSize: MainAxisSize.min,
//        children: <Widget>[
//          const Text('Cookies:'),
//          _getCookieList(cookies),
//        ],
//      ),
//    ));
//  }
//
//  void _onAddToCache(WebViewController controller, BuildContext context) async {
//    await controller.evaluateJavascript(
//        'caches.open("test_caches_entry"); localStorage["test_localStorage"] = "dummy_entry";');
//    Scaffold.of(context).showSnackBar(const SnackBar(
//      content: Text('Added a test entry to cache.'),
//    ));
//  }
//
//  void _onListCache(WebViewController controller, BuildContext context) async {
//    await controller.evaluateJavascript('caches.keys()'
//        '.then((cacheKeys) => JSON.stringify({"cacheKeys" : cacheKeys, "localStorage" : localStorage}))'
//        '.then((caches) => Toaster.postMessage(caches))');
//  }
//
//  void _onClearCache(WebViewController controller, BuildContext context) async {
//    await controller.clearCache();
//    Scaffold.of(context).showSnackBar(const SnackBar(
//      content: Text("Cache cleared."),
//    ));
//  }
//
//  void _onClearCookies(BuildContext context) async {
//    final bool hadCookies = await cookieManager.clearCookies();
//    String message = 'There were cookies. Now, they are gone!';
//    if (!hadCookies) {
//      message = 'There are no cookies.';
//    }
//    Scaffold.of(context).showSnackBar(SnackBar(
//      content: Text(message),
//    ));
//  }
//
//  void _onNavigationDelegateExample(
//      WebViewController controller, BuildContext context) async {
//    final String contentBase64 =
//    base64Encode(const Utf8Encoder().convert(kNavigationExamplePage));
//    controller.loadUrl('data:text/html;base64,$contentBase64');
//  }
//
//  Widget _getCookieList(String cookies) {
//    if (cookies == null || cookies == '""') {
//      return Container();
//    }
//    final List<String> cookieList = cookies.split(';');
//    final Iterable<Text> cookieWidgets =
//    cookieList.map((String cookie) => Text(cookie));
//    return Column(
//      mainAxisAlignment: MainAxisAlignment.end,
//      mainAxisSize: MainAxisSize.min,
//      children: cookieWidgets.toList(),
//    );
//  }
//}
//
//class NavigationControls extends StatelessWidget {
//  const NavigationControls(this._webViewControllerFuture)
//      : assert(_webViewControllerFuture != null);
//
//  final Future<WebViewController> _webViewControllerFuture;
//
//  @override
//  Widget build(BuildContext context) {
//    return FutureBuilder<WebViewController>(
//      future: _webViewControllerFuture,
//      builder:
//          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
//        final bool webViewReady =
//            snapshot.connectionState == ConnectionState.done;
//        final WebViewController controller = snapshot.data;
//        return Row(
//          children: <Widget>[
//            IconButton(
//              icon: const Icon(Icons.arrow_back_ios),
//              onPressed: !webViewReady
//                  ? null
//                  : () async {
//                if (await controller.canGoBack()) {
//                  controller.goBack();
//                } else {
//                  Scaffold.of(context).showSnackBar(
//                    const SnackBar(content: Text("No back history item")),
//                  );
//                  return;
//                }
//              },
//            ),
//            IconButton(
//              icon: const Icon(Icons.arrow_forward_ios),
//              onPressed: !webViewReady
//                  ? null
//                  : () async {
//                if (await controller.canGoForward()) {
//                  controller.goForward();
//                } else {
//                  Scaffold.of(context).showSnackBar(
//                    const SnackBar(
//                        content: Text("No forward history item")),
//                  );
//                  return;
//                }
//              },
//            ),
//            IconButton(
//              icon: const Icon(Icons.replay),
//              onPressed: !webViewReady
//                  ? null
//                  : () {
//                controller.reload();
//              },
//            ),
//          ],
//        );
//      },
//    );
//  }
//}

void main() => runApp(App());

/// 主要入口
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
          home: MTTLocalizations(child: SplashPage(),),
          routes: <String, WidgetBuilder>{
            "login": (BuildContext context) => AppLoginPage(),
          },
        );
      }),
    );
  }
}

///
/// @name LoginApp
/// @description 登录App
/// @author lca
/// @date 2019-10-29
///
class LoginApp extends StatelessWidget {
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
          home: MTTLocalizations(child: AppLoginPage(),),
          routes: <String, WidgetBuilder>{
            "login": (BuildContext context) => AppLoginPage(),
          },
        );
      }),
    );
  }
}

///
/// @name HomeApp
/// @description 进入主页App
/// @author lca
/// @date 2019-10-29
///
class HomeApp extends StatelessWidget {
  final Widget homePage;
  HomeApp(this.homePage);

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
          home: MTTLocalizations(child: homePage),
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

