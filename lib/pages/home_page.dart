import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';


class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    return InnerDrawer(
      scaffold: Scaffold(
        appBar: AppBar(
          leading: RaisedButton(child: Icon(Icons.menu,size: 35,color: Colors.white,),onPressed: (){

          },),
          title: Text("首页"),
        ),
        body: Container(
          color: Colors.amber,
        ),
      ),
      leftOffset: 0.2,
      leftChild: Container(color: Colors.lightBlue,),
    );
  }
}
