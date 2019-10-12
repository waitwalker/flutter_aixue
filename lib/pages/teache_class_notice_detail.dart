import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_aixue/common/color/color.dart';
import 'package:flutter_aixue/common/network/network_manager.dart';
import 'package:flutter_aixue/dao/dao.dart';
import 'package:flutter_aixue/models/class_notice_model.dart';

///
/// @name TeacherClassNoticeDetail
/// @description 教师班级通知详情添加
/// @author lca
/// @date 2019-10-12
///
class TeacherClassNoticeDetail extends StatefulWidget {
  final ActivityList activity;
  TeacherClassNoticeDetail(this.activity);

  @override
  State<StatefulWidget> createState() {
    return _TeacherClassNoticeDetailState();
  }
}

class _TeacherClassNoticeDetailState extends State<TeacherClassNoticeDetail> {
  Future future;

  @override
  void initState() {
    super.initState();

    future = DaoManager.teacherClassNoticeListFetch({
      "jid":"9620132",
      "schoolId":"50043",
      "type":"1",
      "pageNum":"1",
      "activityId":widget.activity.activityId,
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
        title: Text("班级通知详情"),
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
        title: Text("班级通知详情"),
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
        title: Text("班级通知详情"),
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
        title: Text("班级通知详情"),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(icon: Icon(Icons.data_usage), onPressed: () {
              print("单题任务页面 统计按钮");
            },),
          ),
        ],
      ),
    );
  }
}