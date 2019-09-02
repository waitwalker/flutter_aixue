import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_aixue/common/color/color.dart';
import 'package:flutter_aixue/common/redux/app_state.dart';
import 'package:flutter_aixue/common/widgets/smart_drawer.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomePage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
          height: 300,
          color: Colors.amberAccent,
        ),
      ],
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
            height: 200,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8
              ),
              itemBuilder: _itemBuilder,
              itemCount: 5,
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 20,),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text("最近任务",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w300),),
            ),
          ),

          Expanded(
            child: StaggeredGridView.countBuilder(
              crossAxisCount: 6,
              itemCount: 5,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              itemBuilder: _taskItemBuilder,
              staggeredTileBuilder: (int index){
                return StaggeredTile.fit(2);
              },
            ),
          )
          
        ],
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    Map map = itemArray[index];
    return Padding(
      padding: EdgeInsets.only(left: 20,right: 20,top: 30,bottom: 30),
      child:Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.2),spreadRadius: 3,blurRadius: 3,offset: Offset(0, 3))],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 40,
              width: 40,
              child: Icon(map["icon"],color: Colors.white,),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.2),spreadRadius: 2,blurRadius: 2,offset: Offset(0, 2))],
                color: map["color"],
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20),
              child: Text(map["title"],style: TextStyle(fontSize: 16),),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String,dynamic>> itemArray = [
    {"title":"我的课程","icon":Icons.bookmark,"color":Colors.redAccent},
    {"title":"班级管理","icon":Icons.supervised_user_circle,"color":Colors.lightBlueAccent},
    {"title":"班级圈","icon":Icons.send,"color":Colors.greenAccent},
    {"title":"班级通知","icon":Icons.add_alert,"color":Colors.orangeAccent},
    {"title":"校内公告","icon":Icons.library_books,"color":Colors.amberAccent},
  ];

  Widget _taskItemBuilder(BuildContext context, int index) {
    Map map = itemArray[index];
    return Padding(
      padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 30),
      child:Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.2),spreadRadius: 3,blurRadius: 3,offset: Offset(0, 3))],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: 20,top: 15),
              child: Row(
                children: <Widget>[
                  Container(
                    height: 40,
                    width: 40,
                    child: Icon(map["icon"],color: Colors.white,),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.2),spreadRadius: 2,blurRadius: 2,offset: Offset(0, 2))],
                      color: map["color"],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 20)),
                  Container(
                    width: 250,
                    child: Text(
                      "学习 说说信天游sfhhafh发货时看电视分公司是广发换手机号费劲死数据库福建省的讲究的是数据库法国红酒的数据",
                      style: TextStyle(fontSize: 15),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            _descriptionContainer(index),
            
            Padding(padding: EdgeInsets.only(top: 50,left: 20,bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("回延安",style: TextStyle(fontSize: 13,color: Colors.grey),),

                  Row(
                    children: <Widget>[
                      Text("回延安",style: TextStyle(fontSize: 13,color: Colors.grey),),
                      Padding(padding: EdgeInsets.only(left: 30,right: 20),
                        child: Text("回延安",style: TextStyle(fontSize: 13,color: Colors.grey),),

                      ),
                    ],
                  ),
                ],
              ),

            ),
          ],
        ),
      ),
    );
  }

  Widget _descriptionContainer(int index) {
    if (index % 2 == 0) {
      return Padding(padding: EdgeInsets.only(left: 20,right: 20,top: 20,),
        child: Text("阿富汗是开放或多或少妇姑荷箪食规划局地方环境更好看点附近打瞌睡开个肯定会开个会打飞机SDK官方看电视",style: TextStyle(fontSize: 14),),
      );
    } else {
      return Padding(padding: EdgeInsets.only(left: 20,right: 20));
    }
  }

}
