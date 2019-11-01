import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_aixue/common/redux/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';

///
/// @name StudentMessagePage
/// @description 学生消息页面
/// @author lca
/// @date 2019-10-18
///
class StudentMessagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StudentMessageState();
  }
}

class _StudentMessageState extends State<StudentMessagePage> {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(builder: (context, store) {
      return Scaffold(
        appBar: AppBar(
          title: Text("消息"),
        ),
        body: Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.2),spreadRadius: 3,blurRadius: 3,offset: Offset(0, 3))],
              ),
              width: 0.4 * MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: ChatModel.dummyData.length,
                itemBuilder: (context, index) {
                  ChatModel _model = ChatModel.dummyData[index];
                  return Column(
                    children: <Widget>[
                      Divider(
                        height: 12.0,
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          radius: 24.0,
                          backgroundImage: NetworkImage(_model.avatarUrl),
                        ),
                        title: Row(
                          children: <Widget>[
                            Text(_model.name),
                            SizedBox(
                              width: 16.0,
                            ),
                            Text(
                              _model.datetime,
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ],
                        ),
                        subtitle: Text(_model.message),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 14.0,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      );
    });

  }
}

///
/// @name 聊天model
/// @description
/// @author lca
/// @date 2019-10-21
///
class ChatModel {
  final String avatarUrl;
  final String name;
  final String datetime;
  final String message;

  ChatModel({this.avatarUrl, this.name, this.datetime, this.message});

  static final List<ChatModel> dummyData = [
    ChatModel(
      avatarUrl: "https://randomuser.me/api/portraits/women/34.jpg",
      name: "Laurent",
      datetime: "20:18",
      message: "How about meeting tomorrow?",
    ),
    ChatModel(
      avatarUrl: "https://randomuser.me/api/portraits/women/49.jpg",
      name: "Tracy",
      datetime: "19:22",
      message: "I love that idea, it's great!",
    ),
    ChatModel(
      avatarUrl: "https://randomuser.me/api/portraits/women/77.jpg",
      name: "Claire",
      datetime: "14:34",
      message: "I wasn't aware of that. Let me check",
    ),
    ChatModel(
      avatarUrl: "https://randomuser.me/api/portraits/men/81.jpg",
      name: "Joe",
      datetime: "11:05",
      message: "Flutter just release 1.0 officially. Should I go for it?",
    ),
    ChatModel(
      avatarUrl: "https://randomuser.me/api/portraits/men/83.jpg",
      name: "Mark",
      datetime: "09:46",
      message: "It totally makes sense to get some extra day-off.",
    ),
    ChatModel(
      avatarUrl: "https://randomuser.me/api/portraits/men/85.jpg",
      name: "Williams",
      datetime: "08:15",
      message: "It has been re-scheduled to next Saturday 7.30pm",
    ),
  ];
}
