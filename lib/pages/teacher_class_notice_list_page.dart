import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_aixue/common/color/color.dart';
import 'package:flutter_aixue/common/network/network_manager.dart';
import 'package:flutter_aixue/dao/dao.dart';
import 'package:flutter_aixue/models/class_notice_model.dart';
import 'package:flutter_aixue/pages/teache_class_notice_detail.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///
/// @name TeacherClassNoticeListPage
/// @description 教师班级通知列表页面
/// @author lca
/// @date 2019-10-12
///
class TeacherClassNoticeListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TeacherClassNoticeListState();
  }
}

class _TeacherClassNoticeListState extends State<TeacherClassNoticeListPage> {

  Future future;

  List<ActivityList> classNoticeList = [];

  /// 刷新
  RefreshController _refreshController = RefreshController(initialRefresh: true);
  @override
  void initState() {
    super.initState();

    future = DaoManager.teacherClassNoticeListFetch({
      "jid":"9620132",
      "schoolId":"50043",
      "type":"1",
      "pageNum":"1",
    });
  }

  @override
  Widget build(BuildContext context) {
    return _createFutureBuilder();
  }

  ///
  /// @name _createFutureBuilder
  /// @description 构建FutureBuilder
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-10-12
  ///
  _createFutureBuilder() {
    return FutureBuilder(
      builder: _futureBuilder,
      future: future,
    );
  }

  ///
  /// @name _futureBuilder
  /// @description future控件
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-10-12
  ///
  Widget _futureBuilder(BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        return _noneChild();
      case ConnectionState.active:
        return _activeChild();
      case ConnectionState.waiting:
        return _activeChild();
      case ConnectionState.done:
        if (snapshot.hasError) {
          return _errorChild();
        } else {
          if (snapshot.data != null) {
            ResponseData responseData = snapshot.data;
            if (responseData.result && responseData.model != null) {
              ClassNoticeModel classNoticeModel = responseData.model;
              classNoticeList = classNoticeModel.data.activityList;
            } else {
              return _errorChild();
            }
            return _normalChild();
          } else {
            return _errorChild();
          }
        }
        break;
      default :
        return _activeChild();
        break;
    }
  }

  ///
  /// @name _noneChild
  /// @description 没有数据控件站位
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-10-12
  ///
  Widget _noneChild() {
    return Scaffold(
      appBar: AppBar(
        title: Text("班级通知列表"),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios),
          onTap: (){
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(icon: Icon(Icons.data_usage),onPressed: (){
              print("单题任务页面 统计按钮");
            },),
          ),
        ],
      ),
      body: Center(
        child: Text("暂无数据",style: TextStyle(fontSize: 30,color: ETTColor.c1_color),),
      ),
    );
  }

  ///
  /// @name _activeChild
  /// @description 加载中控件站位
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-10-12
  ///
  Widget _activeChild() {
    return Scaffold(
      appBar: AppBar(
        title: Text("班级通知列表"),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios),
          onTap: (){
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(icon: Icon(Icons.data_usage),onPressed: (){
              print("单题任务页面 统计按钮");
            },),
          ),
        ],
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  ///
  /// @name _errorChild
  /// @description 没有数据控件站位
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-10-12
  ///
  Widget _errorChild() {
    return Scaffold(
      appBar: AppBar(
        title: Text("班级通知列表"),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios),
          onTap: (){
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(icon: Icon(Icons.data_usage),onPressed: (){
              print("单题任务页面 统计按钮");
            },),
          ),
        ],
      ),
      body: Center(
        child: Text("遇到错误",style: TextStyle(fontSize: 30,color: ETTColor.c1_color),),
      ),
    );
  }

  ///
  /// @name _normalChild
  /// @description 请求正常站位
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-10-12
  ///
  Widget _normalChild() {
    return Scaffold(
      appBar: AppBar(
        title: Text("班级通知列表"),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios),
          onTap: (){
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(icon: Icon(Icons.data_usage),onPressed: (){
              print("单题任务页面 统计按钮");
            },),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child:SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: WaterDropHeader(
                waterDropColor: Colors.lightGreen,
              ),
              footer: CustomFooter(
                builder: (BuildContext context,LoadStatus mode){
                  Widget body ;
                  if(mode==LoadStatus.idle){
                    body =  Text("pull up load");
                  }
                  else if(mode==LoadStatus.loading){
                    body =  CupertinoActivityIndicator();
                  }
                  else if(mode == LoadStatus.failed){
                    body = Text("Load Failed!Click retry!");
                  } else if(mode == LoadStatus.noMore) {
                    body = Text("没有更多了",style: TextStyle(color: Colors.grey,fontSize: 13),);
                  }
                  else{
                    body = Text("No more Data");
                  }
                  return Container(
                    height: 55.0,
                    child: Center(child:body),
                  );
                },
              ),
              controller: _refreshController,
              onRefresh: (){
                _onRefresh(_refreshController, []);
              },
              child: StaggeredGridView.countBuilder(
                crossAxisCount: 6,
                itemCount: classNoticeList.length,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                itemBuilder: _itemBuilder,
                staggeredTileBuilder: (int index){
                  return StaggeredTile.fit(2);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    ActivityList classNotice = classNoticeList[index];
    return GestureDetector(
      child: Padding(
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
                      child: Icon(Icons.add_alert,color: Colors.white,size: 30,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.2),spreadRadius: 2,blurRadius: 2,offset: Offset(0, 2))],
                        color: Colors.orangeAccent,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 20)),
                    Container(
                      width: Platform.isIOS ? 220 : 250,
                      child: Text(
                        classNotice.activityTitle,
                        style: TextStyle(fontSize: 18),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 20,top: 10,right: 20),
                child: Container(
                  alignment: Alignment.center,
                  height: classNotice.activityPic!= null ? 80 : 10,
                  child: classNotice.activityPic != null ?
                  Image(image: NetworkImage(classNotice.activityPic),fit: BoxFit.fitWidth,) :
                  Container(),
                ),
              ),

              Padding(padding: EdgeInsets.only(top: 10,left: 20,bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(classNotice.activityTime,style: TextStyle(fontSize: 13,color: Colors.grey),),
                    IconButton(icon: Icon(Icons.delete_forever,color: ETTColor.c1_color,size: 30,), onPressed: (){
                      /// 班级通知删除事件回调
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      /// 班级通知item点击事件
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
          return TeacherClassNoticeDetail(classNotice);
        }));
      },
    );
  }

  /// 刷新
  void _onRefresh(RefreshController controller, List<String> data) async {
    if (mounted) {
      future = DaoManager.teacherClassNoticeListFetch({
        "jid":"9620132",
        "schoolId":"50043",
        "type":"1",
        "pageNum":"1",
      });
    }
    controller.refreshCompleted();
  }

}