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
    LastTaskList lastTask = lastTaskList[index];
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
                      child: Icon(Icons.book,color: Colors.white,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.2),spreadRadius: 2,blurRadius: 2,offset: Offset(0, 2))],
                        color: Colors.lightBlue,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 20)),
                    Container(
                      width: Platform.isIOS ? 220 : 250,
                      child: Text(
                        lastTask.taskName,
                        style: TextStyle(fontSize: 15),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(padding: EdgeInsets.only(top: 50,left: 20,bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(lastTask.dateHint,style: TextStyle(fontSize: 13,color: Colors.grey),),

                    Row(
                      children: <Widget>[
                        Text(lastTask.scaleHint,style: TextStyle(fontSize: 13,color: Colors.grey),),
                        Padding(padding: EdgeInsets.only(left: 10,right: 20),
                          child: Icon(Icons.account_box,size: 20,color: Colors.grey,),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      /// 任务详情路由
      onTap: (){
        switch (lastTask.kTaskSubtype) {
          case ETTTaskSubtype.ETTTaskSubtypeResourceStudy:
          /// pad上教师发布的微课任务就是学资源任务中的视频任务
            print("学资源任务");
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return TeacherResourceTaskDetailPage(lastTask);
            }));
            break;
          case ETTTaskSubtype.ETTTaskSubtypeDiscussion:
            print("讨论任务");
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return TeacherDiscussionTaskDetail(lastTask);
            }));
            break;
          case ETTTaskSubtype.ETTTaskSubtypeWebviewObjectiveItem:
            print("单选多选等任务");
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return TeacherPaperItemTaskDetail(lastTask);
            }));
            break;
          case ETTTaskSubtype.ETTTaskSubtypePaperTest:
          /// 这里包括测验任务
            print("成卷测试任务");
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return TeacherPaperTaskDetail(lastTask);
            }));
            break;
          case ETTTaskSubtype.ETTTaskSubtypeAutonomyTest:
          /// 这种任务已经取消
            print("自主测试任务");
            break;
          case ETTTaskSubtype.ETTTaskSubtypeMicroCourse:
            print("微课程任务");
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return TeacherMicroCoursePage(lastTask);
            }));
            break;
          case ETTTaskSubtype.ETTTaskSubtypeRegularTaskVoice:
            print("一般任务语音");
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return TeacherGeneralTaskDetailPage(lastTask);
            }));
            break;
          case ETTTaskSubtype.ETTTaskSubtypeRegularTaskPicture:
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return TeacherGeneralTaskDetailPage(lastTask);
            }));
            print("一般任务图片");
            break;
          case ETTTaskSubtype.ETTTaskSubtypeRegularTaskText:
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return TeacherGeneralTaskDetailPage(lastTask);
            }));
            print("一般任务文本");
            break;
          case ETTTaskSubtype.ETTTaskSubtypeLiveCourse:
            print("直播任务");
            break;
          case ETTTaskSubtype.ETTTaskSubtypeWebviewSubjectiveItem:
            print("主观题任务");
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return TeacherPaperItemTaskDetail(lastTask);
            }));
            break;
          case ETTTaskSubtype.ETTTaskSubtypeKnowledgeGuidance:

            print("知识导学任务");
            break;
          case ETTTaskSubtype.ETTTaskAnswerSheet:
            print("答题卡任务");
            break;
          case ETTTaskSubtype.ETTTaskAISingle:
          /// 已取消
            print("AI单项任务");
            break;
          case ETTTaskSubtype.ETTTaskAIStudyPlan:
          /// 已取消
            print("AI学习计划任务");
            break;
          case ETTTaskSubtype.ETTTaskHoneycomb:
          /// 蜂巢任务
            print("蜂巢任务");

            Navigator.push(context, MaterialPageRoute(builder: (context){
              return TeacherPersonalizedTaskDetail(lastTask);
            }));
            break;
          case ETTTaskSubtype.ETTTaskSingSound:
            print("先声任务");
            break;
        }
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