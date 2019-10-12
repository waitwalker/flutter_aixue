import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_aixue/common/color/color.dart';
import 'package:flutter_aixue/common/network/network_manager.dart';
import 'package:flutter_aixue/dao/dao.dart';
import 'package:flutter_aixue/models/class_notice_model.dart';
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
        }
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

      default :
        return _activeChild();
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
                itemBuilder: _taskItemBuilder,
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