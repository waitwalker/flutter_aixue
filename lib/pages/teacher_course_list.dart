import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aixue/common/network/network_manager.dart';
import 'package:flutter_aixue/common/redux/app_state.dart';
import 'package:flutter_aixue/dao/dao.dart';
import 'package:flutter_aixue/models/teacher_course_list_model.dart';
import 'package:flutter_aixue/models/teacher_subject_list_model.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 教师课程列表
class TeacherCourseList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TeacherCourseListState();
  }
}

class _TeacherCourseListState extends State<TeacherCourseList> {

  String dropdownTitle = "更多学科";
  String dropdownValue;

  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();

  List<SubjectList> subjectList = [];
  List<LessonList> lessonList = [];
  SubjectList currentSubject;

  /// 刷新
  RefreshController _refreshController = RefreshController(initialRefresh: true);

  @override
  void initState() {
    initData();
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
    ResponseData responseData = await DaoManager.teacherSubjectsFetch({"jid":"9620132","schoolId":"50043"});

    print(responseData);
    if (responseData.result) {
      if (responseData.model != null && responseData.model.result == 1) {
        TeacherSubjectListModel subjectListModel = responseData.model;
        if (subjectListModel.data.subjectList.length > 0) {
          subjectList = subjectListModel.data.subjectList;
          setState(() {
            currentSubject = subjectListModel.data.subjectList.first;
            String gradeName = gradeMap[currentSubject.gradeId].toString();
            String subjectName = subjectMap[currentSubject.subjectId].toString();
            dropdownTitle = gradeName + subjectName;
          });

          Future.delayed(Duration(milliseconds: 500),(){
            _fetchCourse(currentSubject);
          });

          return;
        } else {

        }
      } else {

      }
    } else {

    }
  }

  ///
  /// @Method: _fetchCourse
  /// @Parameter:
  /// @ReturnType:
  /// @Description: 根据学科获取课程列表
  /// @author: lca
  /// @Date: 2019-09-03
  ///
  void _fetchCourse(SubjectList subject) async{
    ResponseData responseData = await DaoManager.teacherCourseFetch({"jid":"9620132","schoolId":"50043","subjectId":subject.subjectId,"gradeId":subject.gradeId,"pageNum":"1"});

    print(responseData);
    if (responseData.result) {
      if (responseData.model != null && (responseData.model.result == 1 || responseData.model.result == 2 || responseData.model.result == 3) ) {
        TeacherCourseListModel courseListModel = responseData.model;
        lessonList.clear();
        if (courseListModel.data.lessonList.length > 0) {
          setState(() {
            lessonList = courseListModel.data.lessonList;
            String gradeName = gradeMap[currentSubject.gradeId].toString();
            String subjectName = subjectMap[currentSubject.subjectId].toString();
            dropdownTitle = gradeName + subjectName;
          });

        } else {
          setState(() {
            String gradeName = gradeMap[currentSubject.gradeId].toString();
            String subjectName = subjectMap[currentSubject.subjectId].toString();
            dropdownTitle = gradeName + subjectName;
          });
        }
      } else {

      }
    } else {

    }
  }

  /// 刷新
  void _onRefresh(RefreshController controller) async {
    _fetchCourse(currentSubject);
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
  Widget build(BuildContext context) {

    return StoreBuilder<AppState>(
      builder: (context,store){
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: GestureDetector(
              child: Icon(Icons.arrow_back_ios),
              onTap: (){
                Navigator.of(context).pop();
              },
            ),
            title: DropdownButton(
              underline: Container(),
              items: _dropdownItems(),
              hint: Text(dropdownTitle,style: TextStyle(fontSize: 16),),
              value: dropdownValue,
              onChanged: (value){
                currentSubject = subjectList[value];
                _fetchCourse(currentSubject);
              },
            ),
          ),
          body: homeBodyContainer(),
        );
      },
    );
  }

  var gradeMap = {
    1: '高三',
    2: '高二',
    3: '高一',
    4: '初三',
    5: '初二',
    6: '初一',
    7: '小六',
    8: '小五',
    9: '小四',
    10: '小三',
    11: '小二',
    12: '小一'
  };

  /// 学科
  var subjectMap = {
    0: '全科',
    1: '语文',
    2: '数学',
    3: '英语',
    4: '物理',
    5: '化学',
    6: '历史',
    7: '生物',
    8: '地理',
    9: '政治',
    10: '科学',
    11: '其他'
  };

  List<DropdownMenuItem> _dropdownItems(){
    List<DropdownMenuItem> items= List();

    if (subjectList.length ==0 ) return items;

    for (int i = 0; i < subjectList.length; i++) {
      String gradeName = gradeMap[subjectList[i].gradeId].toString();
      String subjectName = subjectMap[subjectList[i].subjectId].toString();
      DropdownMenuItem dropdownMenuItem = DropdownMenuItem(
        child: Text(
          gradeName + subjectName,
          style: TextStyle(fontSize: 17),
        ),
        value: i,
      );
      items.add(dropdownMenuItem);
    }
    return items;
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
              child: StaggeredGridView.countBuilder(
                crossAxisCount: 6,
                itemCount: lessonList.length > 0 ? lessonList.length : 1,
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

  Widget _taskItemBuilder(BuildContext context, int index) {
    if (lessonList.length == 0) {
      return Padding(padding: EdgeInsets.only(top: 30,left: 180),
        child: Container(
          alignment: Alignment.center,
          child: Text("暂无课程"),
        ),
      );
    }
    LessonList lesson = lessonList[index];
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
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: 50,right: 50,top: 60,bottom: 60),
              child: Text(lesson.lessonName,style: TextStyle(fontSize: 13,color: Colors.grey),),
            ),
          ],
        ),
      ),
    );
  }




}