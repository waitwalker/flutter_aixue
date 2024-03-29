import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_aixue/assistant/enum_assistant.dart';
import 'package:flutter_aixue/common/color/color.dart';
import 'package:flutter_aixue/common/network/network_manager.dart';
import 'package:flutter_aixue/common/redux/app_state.dart';
import 'package:flutter_aixue/common/widgets/smart_drawer.dart';
import 'package:flutter_aixue/dao/dao.dart';
import 'package:flutter_aixue/models/teacher_task_model.dart';
import 'package:flutter_aixue/pages/teacher_app/teacher_class_notice_list_page.dart';
import 'package:flutter_aixue/pages/teacher_app/teacher_discussion_task_detail.dart';
import 'package:flutter_aixue/pages/teacher_app/teacher_general_task_detail.dart';
import 'package:flutter_aixue/pages/teacher_app/teacher_paper_item_task_detail.dart';
import 'package:flutter_aixue/pages/teacher_app/teacher_paper_task_detail.dart';
import 'package:flutter_aixue/pages/teacher_app/teacher_message_page.dart';
import 'package:flutter_aixue/pages/teacher_app/teacher_personal_information_page.dart';
import 'package:flutter_aixue/pages/teacher_app/teacher_setting_page.dart';
import 'package:flutter_aixue/pages/teacher_app/teacher_course_list.dart';
import 'package:flutter_aixue/pages/teacher_app/teacher_micro_course_page.dart';
import 'package:flutter_aixue/pages/teacher_app/teacher_personalized_task_detail.dart';
import 'package:flutter_aixue/pages/teacher_app/teacher_resource_task_detail.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///
/// @name TeacherHomePage
/// @description 教师首页
/// @author lca
/// @date 2019-09-11
///
class TeacherHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<TeacherHomePage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<LastTaskList> lastTaskList = [];

  /// 刷新
  RefreshController _refreshController =
  RefreshController(initialRefresh: true);

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight
    ]);
    super.initState();
  }

  ///
  /// @Method: initData
  /// @Parameter:
  /// @ReturnType:
  /// @Description: 加载数据
  /// @author: lca
  /// @Date: 2019-08-02
  ///
  initData() async {
    ResponseData responseData = await DaoManager.teacherRecentTaskFetch({"jid":"9620132","schoolId":"50043"});
    print(responseData);
    if (lastTaskList.length > 0) lastTaskList.clear();
    if (responseData.result) {
      if (responseData.model != null && responseData.model.result == 1) {
        TeacherTaskModel taskModel = responseData.model;
        if (taskModel.data.lastTaskList.length > 0) {
          setState(() {
            lastTaskList = taskModel.data.lastTaskList;
          });
        } else {

        }
      } else {

      }
    } else {

    }
  }

  /// 刷新
  void _onRefresh(RefreshController controller, List<String> data) async {
    if (mounted) {
      initData();
    }
    controller.refreshCompleted();
  }

  /// 上拉加载更多
  void _onLoading(RefreshController controller, List<String> data) async {
    await Future.delayed(Duration(milliseconds: 2000));
    for (int i = 0; i < 10; i++) {
      data.add("Item $i");
    }
    if (mounted) setState(() {});
    controller.loadComplete();
    controller.loadNoData();
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
  List itemList = [
    {
      "title":"消息",
      "color":Colors.amber
    },
    {
      "title":"我的",
      "color":Colors.amber
    },
    {
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
                return TeacherMessagePage();
                break;
              case 1:
                return TeacherPersonalInformationPage();
                break;
              case 2:
                return TeacherSettingPage();
                break;
              default:
                return TeacherPersonalInformationPage();
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
                itemCount: lastTaskList.length,
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

  ///
  /// @name _itemBuilder
  /// @description item 控件
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-10-18
  ///
  Widget _itemBuilder(BuildContext context, int index) {
    Map map = itemArray[index];
    return GestureDetector(
      child: Padding(
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
      ),
      onTap: (){
        if (index == 3) {
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return TeacherClassNoticeListPage();
          }));
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return TeacherCourseList();
          }));
        }
      },
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
