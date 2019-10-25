import 'package:flutter/material.dart';
import 'package:flutter_aixue/models/teacher_task_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

///
/// @name TeacherPersonalizedTaskDetail
/// @description 教师个性化学习任务详情
/// @author lca
/// @date 2019-10-12
///
class TeacherPersonalizedTaskDetail extends StatefulWidget {
  final LastTaskList task;
  TeacherPersonalizedTaskDetail(this.task);
  @override
  State<StatefulWidget> createState() {
    return _TeacherPersonalizedTaskState();
  }
}

class _TeacherPersonalizedTaskState extends State<TeacherPersonalizedTaskDetail> {

  LastTaskList task;
  WebViewController webViewController;

  @override
  void initState() {
    task = widget.task;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

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
      body: _body(),
    );
  }

  ///
  /// @name _body
  /// @description
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-10-12
  ///
  Widget _body() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        child: WebView(
          initialUrl: task.jspUrl,
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