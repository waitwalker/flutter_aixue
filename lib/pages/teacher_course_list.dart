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


class TeacherCourseList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TeacherCourseListState();
  }
}

class _TeacherCourseListState extends State<TeacherCourseList> {

  String dropdownValue;

  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();

  List<SubjectList> subjectList = [];
  List<LessonList> lessonList = [];

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
    ResponseData responseData = await DaoManager.teacherRecentTaskFetch({"jid":"9620132","schoolId":"50043"});

    print(responseData);
    if (responseData.result) {
      if (responseData.model != null && responseData.model.result == 1) {
        TeacherSubjectListModel subjectListModel = responseData.model;
        if (subjectListModel.data.subjectList.length > 0) {
          subjectList = subjectListModel.data.subjectList;
          SubjectList subject = subjectListModel.data.subjectList.first;


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
              items: getListData(), 
              hint: Text("更多学科"),
              value: dropdownValue,
              onChanged: (value){
                setState(() {
                  dropdownValue = value;
                });
              },),
          ),
        );
      },
    );
  }

  List<DropdownMenuItem> getListData(){
    List<DropdownMenuItem> items= List();
    DropdownMenuItem dropdownMenuItem1= DropdownMenuItem(
      child: Text('1'),
      value: '1',
    );
    items.add(dropdownMenuItem1);
    DropdownMenuItem dropdownMenuItem2= DropdownMenuItem(
      child: Text('2'),
      value: '2',
    );
    items.add(dropdownMenuItem2);
    DropdownMenuItem dropdownMenuItem3= DropdownMenuItem(
      child: Text('3'),
      value: '3',
    );
    items.add(dropdownMenuItem3);
    DropdownMenuItem dropdownMenuItem4= DropdownMenuItem(
      child: Text('4'),
      value: '4',
    );
    items.add(dropdownMenuItem4);
    DropdownMenuItem dropdownMenuItem5= DropdownMenuItem(
      child: Text('5'),
      value: '5',
    );
    items.add(dropdownMenuItem5);
    DropdownMenuItem dropdownMenuItem6= DropdownMenuItem(
      child: Text('6'),
      value: '6',
    );
    items.add(dropdownMenuItem6);
    DropdownMenuItem dropdownMenuItem7= DropdownMenuItem(
      child: Text('7'),
      value: '7',
    );
    items.add(dropdownMenuItem7);
    DropdownMenuItem dropdownMenuItem8= DropdownMenuItem(
      child: Text('8'),
      value: '8',
    );
    items.add(dropdownMenuItem8);
    DropdownMenuItem dropdownMenuItem9= DropdownMenuItem(
      child: Text('9'),
      value: '9',
    );
    items.add(dropdownMenuItem9);
    DropdownMenuItem dropdownMenuItem10= DropdownMenuItem(
      child: Text('10'),
      value: '10',
    );
    items.add(dropdownMenuItem10);
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
                _onRefresh(_refreshController, []);
              },
              child: StaggeredGridView.countBuilder(
                crossAxisCount: 6,
                itemCount: subjectList.length,
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
            Padding(padding: EdgeInsets.only(left: 50,right: 50,top: 30,bottom: 30),
              child: Text(lesson.lessonName,style: TextStyle(fontSize: 13,color: Colors.grey),),
            ),
          ],
        ),
      ),
    );
  }




}