import 'package:flutter/material.dart';
import 'package:flutter_aixue/common/redux/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';

///
/// @name StudentSelfStudyPage
/// @description 学生自学
/// @author lca
/// @date 2019-11-01
///
class StudentSelfStudyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StudentSelfStudyState();
  }
}

class _StudentSelfStudyState extends State<StudentSelfStudyPage> {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(builder: (context, store) {
      return Scaffold(
        appBar: AppBar(
          title: Text("我的班级"),
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