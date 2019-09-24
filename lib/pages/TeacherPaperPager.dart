import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_aixue/common/color/color.dart';
import 'package:flutter_aixue/dao/dao.dart';
import 'package:flutter_aixue/models/teacher_question_model.dart';
import 'package:flutter_aixue/models/teacher_task_detail_model.dart';
import 'package:flutter_aixue/models/teacher_task_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

///
/// @name TeacherPaperPage
/// @description 教师测验页面
/// @author lca
/// @date 2019-09-23
///
class TeacherPaperPage extends StatefulWidget {

  final LastTaskList task;

  TeacherPaperPage(this.task);
  @override
  State<StatefulWidget> createState() {
    return _TeacherPaperState();
  }
}

class _TeacherPaperState extends State<TeacherPaperPage> {
  LastTaskList task;

  TextEditingController commentController = TextEditingController();

  List<UserReplyList> userReplyList;

  /// 是否点击了试卷按钮
  bool isTappedPaper = false;

  /// 是否点击了统计按钮
  bool isTappedStatistics = false;

  WebViewController webViewController;

  TeacherQuestionModel questionModel;

  int currentIndex = 0;

  Future future;

  @override
  void initState() {
    super.initState();
    task = widget.task;

    future = DaoManager.teacherQuestionItemsFetch({
      "jid":"9620132",
      "schoolId":"50043",
      "taskId":task.taskId,
      "classId":"1343842",
      "isBoxExists":"0"
    });
  }

  loadFutureBuilder() {
    return FutureBuilder(
      builder: _futureBuilder,
      future: future,
    );
  }

  Widget _futureBuilder(BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        return futureNoneChild();
      case ConnectionState.active:
        return futureActiveChild();
      case ConnectionState.waiting:
        return futureWaitingChild();
      case ConnectionState.done:
        if (snapshot.hasError) {
          return futureErrorChild();
        }

        if (!snapshot.hasData || snapshot.data.model == null) {
          return Text('没有数据');
        }

        if (snapshot.data.result) {
          if (snapshot.data.model != null && snapshot.data.model.result == 1) {
            TeacherQuestionModel microCourseModel = snapshot.data.model;
            if (microCourseModel != null) {
              print("$microCourseModel");
              questionModel = microCourseModel;
              return futureDoneChild();
            } else {
              return futureWaitingChild();
            }
          } else {
            return futureWaitingChild();
          }
        } else {
          return futureWaitingChild();
        }
        break;
      default:
        return futureWaitingChild();
    }
  }

  @override
  Widget build(BuildContext context) {
    return loadFutureBuilder();
  }

  ///
  /// @name futureNoneChild
  /// @description 准备请求的Widget
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-09-11
  ///
  Widget futureNoneChild() {
    return Scaffold(
      appBar: AppBar(
        title: Text("微课程"),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios),
          onTap: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Container(
          child: Text("准备加载..."),
        ),
      ),
    );
  }

  ///
  /// @name futureNoneChild
  /// @description 准备请求的Widget
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-09-11
  ///
  Widget futureActiveChild() {
    return Scaffold(
      appBar: AppBar(
        title: Text("微课程"),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios),
          onTap: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Center(
          child: Container(
            child: Text("加载..."),
          ),
        ),
      ),
    );
  }

  ///
  /// @name futureNoneChild
  /// @description 请求中的Widget
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-09-11
  ///
  Widget futureWaitingChild() {
    return Scaffold(
      appBar: AppBar(
        title: Text("微课程"),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios),
          onTap: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  ///
  /// @name futureDoneChild
  /// @description 请求完成的Widget
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-09-11
  ///
  Widget futureDoneChild() {
    return Scaffold(
      appBar: AppBar(
        title: Text("测验"),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios),
          onTap: (){
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.data_usage,size: 30,color: isTappedStatistics ? ETTColor.c1_color : Colors.black54,), onPressed: (){
            isTappedStatistics = !isTappedStatistics;
            isTappedPaper = false;
            setState(() {
            });
          },),
        ],
      ),
      body: leftChild(),
    );
  }

  ///
  /// @name futureErrorChild
  /// @description 准备请求的Widget
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-09-11
  ///
  Widget futureErrorChild() {
    return Scaffold(
      appBar: AppBar(
        title: Text("微课程"),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios),
          onTap: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Container(
          child: Text("错误"),
        ),
      ),
    );
  }

  ///
  /// @name leftChild
  /// @description 根据资源类型返回特定组件
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-09-12
  ///
  Widget leftChild() {
    return Column(
      children: <Widget>[
        Container(
          height: 632,
          child: WebView(
            initialUrl: task.jspUrl + "&versionName=V2.0.4",
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
        Padding(padding: EdgeInsets.only(top: 10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: FlatButton(onPressed: (){
                currentIndex --;
                if (currentIndex == -1) {
                  currentIndex = 0;
                  webViewController.evaluateJavascript("tqControler.showQuesCard()");
                } else {
                  webViewController.evaluateJavascript("document.getElementById(\"fm_free\").submit()");
                }
              }, child: Text("上一题",style: TextStyle(fontSize: 18,color: ETTColor.c1_color),)),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: FlatButton(onPressed: (){
                currentIndex ++;
                if (currentIndex == questionModel.data.questionList.length) {
                  currentIndex = 0;
                  webViewController.evaluateJavascript("tqControler.showQuesCard()");
                } else {
                  webViewController.evaluateJavascript("document.getElementById(\"fm_next\").submit()");
                }
              }, child: Text("下一题",style: TextStyle(fontSize: 18,color: ETTColor.c1_color),)),
            ),
          ],
        ),
      ],
    );
  }


}