import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_aixue/common/redux/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';

///
/// @name 发布班级通知
/// @description 
/// @author lca
/// @date 2019-10-24
///
class TeacherPublishClassNoticePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TeacherPublishClassNoticeState();
  }
}

class _TeacherPublishClassNoticeState extends State<TeacherPublishClassNoticePage> {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(builder: (context, store) {
      return Scaffold(
        appBar: AppBar(
          title: Text("个性化任务"),
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios),
            onTap: (){
              Navigator.pop(context);
            },
          ),
        ),
      );
    });
  }
}