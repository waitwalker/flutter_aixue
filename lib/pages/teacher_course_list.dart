import 'package:flutter/material.dart';
import 'package:flutter_aixue/common/redux/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';


class TeacherCourseList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TeacherCourseListState();
  }
}

class _TeacherCourseListState extends State<TeacherCourseList> {

  String dropdownValue;

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
    List<DropdownMenuItem> items=new List();
    DropdownMenuItem dropdownMenuItem1=new DropdownMenuItem(
      child:new Text('1'),
      value: '1',
    );
    items.add(dropdownMenuItem1);
    DropdownMenuItem dropdownMenuItem2=new DropdownMenuItem(
      child:new Text('2'),
      value: '2',
    );
    items.add(dropdownMenuItem2);
    DropdownMenuItem dropdownMenuItem3=new DropdownMenuItem(
      child:new Text('3'),
      value: '3',
    );
    items.add(dropdownMenuItem3);
    DropdownMenuItem dropdownMenuItem4=new DropdownMenuItem(
      child:new Text('4'),
      value: '4',
    );
    items.add(dropdownMenuItem4);
    DropdownMenuItem dropdownMenuItem5=new DropdownMenuItem(
      child:new Text('5'),
      value: '5',
    );
    items.add(dropdownMenuItem5);
    DropdownMenuItem dropdownMenuItem6=new DropdownMenuItem(
      child:new Text('6'),
      value: '6',
    );
    items.add(dropdownMenuItem6);
    DropdownMenuItem dropdownMenuItem7=new DropdownMenuItem(
      child:new Text('7'),
      value: '7',
    );
    items.add(dropdownMenuItem7);
    DropdownMenuItem dropdownMenuItem8=new DropdownMenuItem(
      child:new Text('8'),
      value: '8',
    );
    items.add(dropdownMenuItem8);
    DropdownMenuItem dropdownMenuItem9=new DropdownMenuItem(
      child:new Text('9'),
      value: '9',
    );
    items.add(dropdownMenuItem9);
    DropdownMenuItem dropdownMenuItem10=new DropdownMenuItem(
      child:new Text('10'),
      value: '10',
    );
    items.add(dropdownMenuItem10);
    return items;
  }



}