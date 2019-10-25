import 'package:flutter/material.dart';
import 'package:flutter_aixue/common/redux/app_state.dart';
import 'package:flutter_aixue/pages/teacher_app/home_page.dart';
import 'package:flutter_aixue/pages/teacher_app/message_page.dart';
import 'package:flutter_aixue/pages/teacher_app/setting_page.dart';
import 'package:flutter_redux/flutter_redux.dart';





/// 底部页面+导航
class TabNavigator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TabNavigatorState();
  }
}

class _TabNavigatorState extends State<TabNavigator> {

  // 默认颜色 未选中
  final Color _defaultColor = Colors.grey;

  // 选中状态下颜色
  final Color _activeColor = Colors.blue;

  // 当前索引 选中 控制选中哪个页面
  int _currentIndex = 0;

  // 管理pageView
  final PageController _controller = PageController(
    initialPage: 0,//初始页面
  );

  @override
  Widget build(BuildContext context) {

    return StoreBuilder<AppState>(
      builder: (context,store){
        return Scaffold(
          body: PageView(
            physics: NeverScrollableScrollPhysics(),//关闭整个页面的联动
            controller: _controller,
            // children显示得是页面 四个主页面
            children: <Widget>[
              HomePage(),
              MessagePage(),
            ],
          ),
          drawer: SettingPage(),

          // 底部导航
          bottomNavigationBar: BottomNavigationBar(
              backgroundColor: store.state.theme.themeData.primaryColor,
              currentIndex: _currentIndex, //当前索引 第几页
              onTap: (index){ //切换当前索引
                setState(() {
                  _controller.jumpToPage(index);//跳转到相印页面
                  _currentIndex = index;
                });
              },
              type: BottomNavigationBarType.fixed,//将item固定
              items: [
                // 首页item
                BottomNavigationBarItem(
                    icon: Icon(Icons.home,color: _defaultColor,), //未选中
                    activeIcon:Icon(Icons.home,color: _activeColor,),//选中
                    title: Text("首页",style: TextStyle(
                      color: _currentIndex != 0 ? _defaultColor : _activeColor,
                    ),)
                ),

                // 我的item
                BottomNavigationBarItem(
                    icon: Icon(Icons.search,color: _defaultColor,), //未选中
                    activeIcon:Icon(Icons.search,color: _activeColor,),//选中
                    title: Text("消息",style: TextStyle(
                      color: _currentIndex != 1 ? _defaultColor : _activeColor,
                    ),)
                ),
              ]
          ),
        );
      },
    );
  }
}