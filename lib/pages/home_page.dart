import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_aixue/common/redux/app_state.dart';
import 'package:flutter_aixue/common/widgets/smart_drawer.dart';
import 'package:flutter_redux/flutter_redux.dart';


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
            leading: RaisedButton(child: Icon(Icons.menu,color: Colors.lightBlueAccent,size: 30,),onPressed: (){
              _scaffoldKey.currentState.openDrawer();
            },),
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
              itemBuilder: itemBuilder,
              itemCount: 5,
            ),
          ),
          
        ],
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    Map map = itemArray[index];
    return Padding(
      padding: EdgeInsets.only(left: 20,right: 20,top: 30,bottom: 30),
      child:Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.2),spreadRadius: 3,blurRadius: 3,offset: Offset(0, -3))],
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
                color: map["color"]
              ),
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
}
