import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_aixue/common/color/color.dart';
import 'package:flutter_aixue/common/network/network_manager.dart';
import 'package:flutter_aixue/common/redux/app_state.dart';
import 'package:flutter_aixue/dao/dao.dart';
import 'package:flutter_aixue/models/class_notice_detail_model.dart';
import 'package:flutter_aixue/models/class_notice_model.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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

  ClassNoticeDetailModel detailModel;
  RefreshController _refreshController = RefreshController(initialRefresh: true);
  TextEditingController commentController = TextEditingController();
  @override
  void initState() {
    super.initState();

    future = DaoManager.teacherClassNoticeDetailFetch({
      "jid":"9620132",
      "schoolId":"50043",
      "type":"1",
      "pageNum":"1",
      "activityId":widget.activity.activityId,
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(builder: (context, store) {
      return _createFutureBuilder();
    });
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
              ClassNoticeDetailModel detail = responseData.model;
              detailModel = detail;
              return _normalChild(detailModel);
            } else {
              return _errorChild();
            }
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
  /// @description 请求完成的Widget
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-09-11
  ///
  Widget _normalChild(ClassNoticeDetailModel detailModel) {
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
          IconButton(
            icon: Icon(Icons.comment,size: 24,color: Colors.orangeAccent,),
            onPressed: (){
              showDialog(barrierDismissible: false,context: context,builder: (BuildContext context){
                return GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Padding(padding: EdgeInsets.only(left: 0.6 * MediaQuery.of(context).size.width,bottom: 0.85 * MediaQuery.of(context).size.height),
                      child: Container(
                        height: 200,
                        width: 0.4 * MediaQuery.of(context).size.width,
                        color: ETTColor.background_color,
                        child: Padding(padding: EdgeInsets.only(left: 20,top: 15,bottom: 10),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 0.4 * MediaQuery.of(context).size.width - 120,
                                child: CupertinoTextField(
                                  controller: commentController,
                                  placeholder: "输入内容",
                                  autofocus: true,
                                  maxLines: 5,
                                  maxLength: 300,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(left: 5),
                                child: RaisedButton(
                                  child: Icon(Icons.send,size: 30,color: ETTColor.c1_color,),
                                  onPressed: (){
                                    print("评论的内容:${commentController.text}");
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              });
            },
          ),
        ],
      ),
      body: Row(
        children: <Widget>[

          /// 左边
          Container(
            width: 0.6 * MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border(right: BorderSide(color: Colors.lightBlue,width: 2.0))
            ),
            child: _leftColumn(detailModel),
          ),

          /// 右边
          Container(
            width: 0.4 * MediaQuery.of(context).size.width,
            child: Column(
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
                      _onRefresh(_refreshController);
                    },
                    child: ListView.builder(
                      itemCount: detailModel.data.secondaryReplyList != null ? detailModel.data.secondaryReplyList.length : 0,
                      itemBuilder: _itemBuilder,),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 刷新
  void _onRefresh(RefreshController controller) async {
//    _fetchCourse(currentSubject);
    controller.refreshCompleted();
  }

  ///
  /// @name _itemBuilder
  /// @description 回复卡片
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-10-12
  ///
  Widget _itemBuilder(BuildContext context, int index) {
    SecondaryReplyList userReply = detailModel.data.secondaryReplyList[index];
    return Padding(
      padding: EdgeInsets.all(15),
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xFFF2F7FF),
            borderRadius: BorderRadius.circular(5),
            boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.3),offset: Offset(0, 3),blurRadius: 3,spreadRadius: 3)]
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(left: 10,top: 10),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(image: NetworkImage(userReply.userInfo.userPhoto),fit: BoxFit.cover),
                      ),
                    )
                ),

                Padding(
                  padding: EdgeInsets.only(left: 10,top: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(userReply.userInfo.userName,style: TextStyle(fontSize: 15,color: ETTColor.c1_color),),
                      Text(userReply.replyTime,style: TextStyle(fontSize: 10,color: Colors.orangeAccent),),
                    ],
                  ),
                ),
              ],
            ),

            Padding(padding: EdgeInsets.only(left: 15,right: 15,top: 15),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(userReply.replyContent),
              ),
            ),

            Padding(padding: EdgeInsets.only(top: 15)),

            Padding(padding: EdgeInsets.only(left: 10,right: 10),
              child: Container(
                height: 1.0,
                color: Colors.grey,
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 15)),
          ],
        ),
      ),
    );
  }

  Widget _leftColumn(ClassNoticeDetailModel detailModel) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 20,top: 10),
          child: Text(widget.activity.activityTitle,style: TextStyle(fontSize: 25,color: ETTColor.c1_color),),
        ),
        
        Padding(
          padding: EdgeInsets.only(top: 10,left: 20,right: 20),
          child: widget.activity.activityPic != null ? 
          Image(image: NetworkImage(widget.activity.activityPic)) :
          Container(),
        ),
        Padding(padding: EdgeInsets.only(top: 10,left: 20),
          child: Text(detailModel.data.replyContent,style: TextStyle(fontSize: 20,color: Colors.black54),),
        ),
      ],
    );
  }
}