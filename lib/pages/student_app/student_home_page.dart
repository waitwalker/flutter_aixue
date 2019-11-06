import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_aixue/common/color/color.dart';
import 'package:flutter_aixue/common/redux/app_state.dart';
import 'package:flutter_aixue/common/widgets/smart_drawer.dart';
import 'package:flutter_aixue/pages/login_register/app_login_manager.dart';
import 'package:flutter_aixue/pages/student_app/student_class_page.dart';
import 'package:flutter_aixue/pages/student_app/student_home_content_page.dart';
import 'package:flutter_aixue/pages/student_app/student_message_page.dart';
import 'package:flutter_aixue/pages/student_app/student_personal_information_page.dart';
import 'package:flutter_aixue/pages/student_app/student_personalized_recommendation_page.dart';
import 'package:flutter_aixue/pages/student_app/student_self_study_page.dart';
import 'package:flutter_aixue/pages/student_app/student_setting_page.dart';
import 'package:flutter_redux/flutter_redux.dart';

///
/// @name StudentHomePage
/// @description 学生主页
/// @author lca
/// @date 2019-10-29
///
class StudentHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StudentHomeState();
  }
}

class _StudentHomeState extends State<StudentHomePage> with SingleTickerProviderStateMixin{

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TabController _tabController;

  double topHeaderHeight = 80.0;

  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: 5);
    _tabController.addListener(() {
      print(_tabController.toString());
      print(_tabController.index);
      print(_tabController.length);
      print(_tabController.previousIndex);
    });
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight
    ]);
    super.initState();
  }


  @override
  void didChangeDependencies() {
    print("依赖发生变化,initState之后调用");
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    print("页面不可交互");
    super.deactivate();
  }

  @override
  void dispose() {
    print("销毁了");
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      builder: (context,store){
        return Scaffold(
          key: _scaffoldKey,
          drawer: SmartDrawer(
            widthPercent: 0.3,
            callback: (opened){
              print("drawer open state:$opened");
            },
            child: drawerContainer(),
          ),
          appBar: AppBar(
            backgroundColor: ETTColor.c1_color,
            leading: RaisedButton(color: Colors.transparent,child: Icon(Icons.menu,color: Colors.lightBlueAccent,size: 30,),onPressed: (){
              _scaffoldKey.currentState.openDrawer();
            },),
            title: Text("首页",style: TextStyle(fontSize: 18,color: Colors.white),),
          ),
          body: homeBodyContainer(),
        );
      },
    );
  }

  ///
  /// @Method: drawerContainer
  /// @Parameter:
  /// @ReturnType:
  /// @Description: 抽屉容器
  /// @author: lca
  /// @Date: 2019-09-02
  ///
  Widget drawerContainer() {
    return Column(
      children: <Widget>[
        Container(
          height: 0.3 * MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.2),spreadRadius: 3,blurRadius: 3,offset: Offset(0, 3))],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 40)),
              Container(
                decoration: BoxDecoration(
                  color: ETTColor.c1_color,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.2),spreadRadius: 3,blurRadius: 3,offset: Offset(0, 3))],
                ),
                height: 80,
                width: 80,
                child: CachedNetworkImage(
                  imageUrl: AppLoginManager.instance.loginModel.photo,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                          colorFilter:
                          ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
                    ),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),

              Padding(padding: EdgeInsets.only(top: 20)),
              Text("张三",style: TextStyle(fontSize: 20),),
            ],
          ),
        ),

        Expanded(child: ListView.builder(itemBuilder: drawerItemBuilder,itemCount: itemList.length,)),
      ],
    );
  }

  /// 抽屉items
  List itemList = [{
      "title":"我的班级",
      "color":Colors.amber
    },{
      "title":"自学",
      "color":Colors.amber
    }, {
      "title":"个性化学习",
      "color":Colors.amber
    }, {
      "title":"消息",
      "color":Colors.amber
    }, {
      "title":"我的",
      "color":Colors.amber
    }, {
      "title":"设置",
      "color":ETTColor.c1_color
    },
  ];

  ///
  /// @name drawerItemBuilder
  /// @description 抽屉页面item
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-09-18
  ///
  Widget drawerItemBuilder(BuildContext context, int index) {
    Map map = itemList[index];
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: RaisedButton(
        child: Container(
          height: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(left: 20),),
                  Icon(Icons.settings,size: 30,color: map["color"],),
                  Padding(padding: EdgeInsets.only(left: 10),),
                  Text(map["title"],style: TextStyle(fontSize: 18),),
                ],
              ),
            ],
          ),
        ),
        onPressed: (){
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
            switch (index) {
              case 0:
                return StudentClassPage();
                break;
              case 1:
                return StudentSelfStudyPage();
                break;
              case 2:
                return StudentPersonalizedRecommendationPage();
                break;
              case 3:
                return StudentMessagePage();
                break;
              case 4:
                return StudentPersonalInformationPage();
                break;
              case 5:
                return StudentSettingPage();
                break;
              default:
                return StudentSelfStudyPage();
                break;
            }
          }));
        },
      ),
    );
  }

  ///
  /// @Method: homeBodyContainer
  /// @Parameter:
  /// @ReturnType:
  /// @Description: 首页body容器
  /// @author: lca
  /// @Date: 2019-09-02
  ///
  Widget homeBodyContainer() {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          Container(
            height: topHeaderHeight,
            child: Padding(padding: EdgeInsets.only(top: 20,),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(left: 20)),
                  Text("我的任务(未完成14)",style: TextStyle(fontSize: 20),),
                  Padding(padding: EdgeInsets.only(left: 580)),
                  Icon(Icons.search),
                ],
              ),
            ),
          ),

          Container(
            height: 50,
            color: Colors.amber,
            child: TabBar(
              controller: _tabController,
              tabs: <Widget>[
                Tab(text: '女装'),
                Tab(text: '男装'),
                Tab(text: '童装'),
                Tab(text: '夏装'),
                Tab(text: '冬装'),
              ],
            ),
          ),


          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                StudentHomeContentPage(),
                Container(color: Colors.greenAccent,),
                StudentHomeContentPage(),
                Container(color: Colors.deepPurple,),
                StudentHomeContentPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
