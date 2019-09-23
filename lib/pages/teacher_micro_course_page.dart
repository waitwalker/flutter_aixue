import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_aixue/models/teacher_task_model.dart';

///
/// @name TeacherMicroCoursePage
/// @description 教师微课程页面
/// @author lca
/// @date 2019-09-23
///
class TeacherMicroCoursePage extends StatefulWidget {

  final LastTaskList task;

  TeacherMicroCoursePage(this.task);
  @override
  State<StatefulWidget> createState() {
    return _TeacherMicroCourseState();
  }
}

class _TeacherMicroCourseState extends State<TeacherMicroCoursePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("微课程"),
        leading: GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(

      ),
    );
  }
}