import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_aixue/models/teacher_task_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

///
/// @name TeacherInteractionCommunicationTaskPage
/// @description 教师互动交流(讨论)任务 h5
/// @author lca
/// @date 2019-09-26
///
class TeacherInteractionCommunicationTaskPage extends StatefulWidget {
  final LastTaskList task;
  TeacherInteractionCommunicationTaskPage(this.task);
  @override
  State<StatefulWidget> createState() {
    return _TeacherInteractionCommunicationTaskState();
  }
}

class _TeacherInteractionCommunicationTaskState extends State<TeacherInteractionCommunicationTaskPage> {
  LastTaskList task;
  WebViewController webViewController;


  @override
  void initState() {
    this.task = widget.task;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("讨论"),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios),
          onTap: (){
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(icon: Icon(Icons.data_usage),onPressed: (){
              print("讨论页面 统计按钮");
            },),
          ),
        ],
      ),
      body: _body(),
    );
  }

  ///
  /// @name _body
  /// @description 根据资源类型返回特定组件
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-09-12
  ///
  Widget _body() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        child: WebView(
          initialUrl: task.jspUrl + "&versionName=V2.1.1",
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
          onPageFinished: (url){
            print("加载完成:$url");
          },
          navigationDelegate: (NavigationRequest request) {
            //对于需要拦截的操作 做判断
            if(request.url.startsWith("myapp://")) {
              print("即将打开 ${request.url}");
              //做拦截处理
              //pushto....
              return NavigationDecision.prevent;
            }

            //不需要拦截的操作
            return NavigationDecision.navigate;
          },
          javascriptChannels: <JavascriptChannel>[
            /// js 调用Flutter 只有postMessage或者拦截url
            JavascriptChannel(
                name: "message",
                onMessageReceived: (JavascriptMessage message) {
                  print("参数： ${message.message}");
                }
            ),
          ].toSet(),

        ),
      ),
    );
  }
}

