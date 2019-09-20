import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_aixue/common/color/color.dart';


class PersonalInformationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PersonState();
  }
}

class _PersonState extends State<PersonalInformationPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
      ),
      body: Container(
        color: ETTColor.c1_color,
      ),
    );
  }
}
