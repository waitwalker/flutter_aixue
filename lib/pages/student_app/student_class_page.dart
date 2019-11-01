import 'package:flutter/material.dart';
import 'package:flutter_aixue/common/redux/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';

///
/// @name StudentClassPage
/// @description 学生我的班级
/// @author lca
/// @date 2019-11-01
///
class StudentClassPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StudentClassState();
  }
}

class _StudentClassState extends State<StudentClassPage> {
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