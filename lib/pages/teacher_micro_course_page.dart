import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_aixue/common/color/color.dart';
import 'package:flutter_aixue/common/network/network_manager.dart';
import 'package:flutter_aixue/common/widgets/photo_view.dart';
import 'package:flutter_aixue/common/widgets/video_player_widget.dart';
import 'package:flutter_aixue/dao/dao.dart';
import 'package:flutter_aixue/models/teacher_question_model.dart';
import 'package:flutter_aixue/models/teacher_task_detail_model.dart';
import 'package:flutter_aixue/models/teacher_task_model.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:webview_flutter/webview_flutter.dart';

///
/// @name TeacherMicroCoursePage
/// @description 教师微课程页面
/// @author lca
/// @date 2019-09-23
///
class TeacherMicroCoursePage extends StatefulWidget {

  final LastTaskList task;

  TeacherMicroCoursePage(this.task);
  @override
  State<StatefulWidget> createState() {
    return _TeacherMicroCourseState();
  }
}

class _TeacherMicroCourseState extends State<TeacherMicroCoursePage> {
  LastTaskList task;

  /// 刷新
  RefreshController _refreshController = RefreshController(initialRefresh: true);
  TextEditingController commentController = TextEditingController();

  List<UserReplyList> userReplyList;

  TeacherTaskDetailModel detailModel;

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

    future = DaoManager.teacherTaskDetailMicroCourseFetch({
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
            TeacherTaskDetailModel microCourseModel = snapshot.data.model;
            if (microCourseModel != null) {
              print("$microCourseModel");
              detailModel = microCourseModel;
              userReplyList = detailModel.data.userReplyList;
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
        title: Text("微课程-文档"),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios),
          onTap: (){
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          Row(
            children: <Widget>[
              IconButton(icon: Icon(Icons.web_asset,size: 30,color: isTappedPaper ? ETTColor.c1_color : Colors.black54,), onPressed: (){
                isTappedPaper = !isTappedPaper;
                isTappedStatistics = false;
                setState(() {
                });
                loadQuestionItems();
              },),
              IconButton(icon: Icon(Icons.data_usage,size: 30,color: isTappedStatistics ? ETTColor.c1_color : Colors.black54,), onPressed: (){
                isTappedStatistics = !isTappedStatistics;
                isTappedPaper = false;
                setState(() {
                });
              },),
              Padding(padding: EdgeInsets.only(left: 15),),
            ],
          ),
        ],
      ),
      body: Row(
        children: <Widget>[
          /// 左边
          Container(
            width: 0.6 * MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border(right: BorderSide(color: Colors.lightBlue,width: 2.0))
            ),
            child: leftChild(),
          ),

          /// 右边
          Container(
            width: 0.4 * MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Expanded(
                  child:SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    header: WaterDropHeader(
                      waterDropColor: Colors.lightGreen,
                    ),
                    footer: CustomFooter(
                      builder: (BuildContext context,LoadStatus mode){
                        Widget body ;
                        if(mode==LoadStatus.idle){
                          body =  Text("pull up load");
                        }
                        else if(mode==LoadStatus.loading){
                          body =  CupertinoActivityIndicator();
                        }
                        else if(mode == LoadStatus.failed){
                          body = Text("Load Failed!Click retry!");
                        } else if(mode == LoadStatus.noMore) {
                          body = Text("没有更多了",style: TextStyle(color: Colors.grey,fontSize: 13),);
                        }
                        else{
                          body = Text("No more Data");
                        }
                        return Container(
                          height: 55.0,
                          child: Center(child:body),
                        );
                      },
                    ),
                    controller: _refreshController,
                    onRefresh: (){
                      _onRefresh(_refreshController);
                    },
                    child: ListView.builder(
                      itemCount: userReplyList.length,
                      itemBuilder: _itemBuilder,),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
    if (!isTappedPaper && !isTappedStatistics) {
      if (detailModel.data.videoUrl != null && detailModel.data.videoUrl.length > 0) {
        return VideoPlayerWidget();
      } else {
        return Container();
      }
    } else {
      if (isTappedPaper) {
        return Column(
          children: <Widget>[
            Container(
              height: 632,
              child: WebView(
                initialUrl: detailModel.data.jspUrl + "&versionName=V2.0.4",
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

      if (isTappedStatistics) {
        return Container(
          child: Center(
            child: Text("统计"),
          ),
        );
      }

      return Container();
    }
  }

  ///
  /// @name loadQuestionItems
  /// @description 获取试题
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-09-24
  ///
  loadQuestionItems() async {
    ResponseData responseData = await DaoManager.teacherQuestionItemsFetch({
      "jid":"9620132",
      "schoolId":"50043",
      "taskId":task.taskId,
      "classId":"1343842",
      "isBoxExists":"0"
    });

    if (responseData.result) {
      if (responseData.model.data != null && responseData.model.result == 1) {
        questionModel = responseData.model;
      }
    }
  }


  /// 刷新
  void _onRefresh(RefreshController controller) async {
//    _fetchCourse(currentSubject);
    controller.refreshCompleted();
  }

  ///
  /// @name _itemBuilder
  /// @description 右边列表item
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-09-23
  ///
  Widget _itemBuilder(BuildContext context, int index) {
    UserReplyList userReply = userReplyList[index];
    return Padding(
      padding: EdgeInsets.all(15),
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xFFF2F7FF),
            borderRadius: BorderRadius.circular(5),
            boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.3),offset: Offset(0, 3),blurRadius: 3,spreadRadius: 3)]
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(left: 10,top: 10),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image(image: NetworkImage(userReply.userInfo.userPhoto)),
                    )
                ),
              ],
            ),

            Padding(padding: EdgeInsets.only(left: 15,right: 15),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(userReply.replyContent),
              ),
            ),

            _imagesContainer(index, userReply.resourceList),
            Padding(padding: EdgeInsets.only(top: 30)),

            Padding(padding: EdgeInsets.only(left: 10,right: 10),
              child: Container(
                height: 1.0,
                color: Colors.grey,
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 15)),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(left: 80,),
                  child: GestureDetector(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.sentiment_satisfied,size: 24,color: userReply.isPrised == 1 ? ETTColor.c1_color : Colors.grey,),

                        Padding(padding: EdgeInsets.only(left: 5),
                          child: Text("${userReply.priseNum}",style: TextStyle(fontSize: 16,color: Colors.grey),),
                        ),

                      ],
                    ),
                    onTap: (){

                    },
                  ),
                ),

                Padding(padding: EdgeInsets.only(right: 80,),
                  child: GestureDetector(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.comment,size: 24,color: ETTColor.c1_color,),

                        Padding(padding: EdgeInsets.only(left: 5),
                          child: Text("${userReply.replyNum}",style: TextStyle(fontSize: 16,color: Colors.grey),),
                        ),

                      ],
                    ),
                    onTap: (){
                      showDialog(barrierDismissible: false,context: context,builder: (BuildContext context){
                        return GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Padding(padding: EdgeInsets.only(left: 0.6 * MediaQuery.of(context).size.width,bottom: 0.85 * MediaQuery.of(context).size.height),
                              child: Container(
                                height: 200,
                                width: 0.4 * MediaQuery.of(context).size.width,
                                color: ETTColor.background_color,
                                child: Padding(padding: EdgeInsets.only(left: 20,top: 15,bottom: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 0.4 * MediaQuery.of(context).size.width - 120,
                                        child: CupertinoTextField(
                                          controller: commentController,
                                          placeholder: "输入内容",
                                          autofocus: true,
                                          maxLines: 5,
                                          maxLength: 300,
                                        ),
                                      ),
                                      Padding(padding: EdgeInsets.only(left: 5),
                                        child: RaisedButton(
                                          child: Icon(Icons.send,size: 30,color: ETTColor.c1_color,),
                                          onPressed: (){
                                            print("评论的内容:${commentController.text}");
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                    },
                  ),
                ),
              ],
            ),

            Padding(padding: EdgeInsets.only(top: 15)),
          ],
        ),
      ),
    );
  }

  ///
  /// @name _imagesContainer
  /// @description 右边图片容器
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-09-23
  ///
  Widget _imagesContainer(int currentSection, List<ResourceList> resourceList) {
    if (resourceList == null || resourceList.length == 0) {
      return Container();
    } else {
      switch (resourceList.length) {
        case 1:
          return Container(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[0].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第1张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 0,)));
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
          break;

        case 2:
          return Container(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[0].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第1张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 0,)));
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[1].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第2张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 1,)));
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
          break;

        case 3:
          return Container(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[0].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第1张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 0,)));
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[1].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第2张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 1,)));
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[2].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第3张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 2,)));
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
          break;

        case 4:
          return Container(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[0].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第1张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 0,)));
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[1].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第2张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 1,)));
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[2].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第3张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 2,)));
                      },
                    ),
                  ],
                ),

                Padding(padding: EdgeInsets.only(top: 10)),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[3].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第4张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 3,)));
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
          break;

        case 5:
          return Container(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[0].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第1张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 0,)));
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[1].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第2张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 1,)));
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[2].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第3张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 2,)));
                      },
                    ),
                  ],
                ),

                Padding(padding: EdgeInsets.only(top: 10)),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[3].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第4张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 3,)));
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[4].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第5张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 4,)));
                      },
                    ),
                  ],
                ),

              ],
            ),
          );
          break;

        case 6:
          return Container(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[0].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第1张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 0,)));
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[1].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第2张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 1,)));
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[2].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第3张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 2,)));
                      },
                    ),
                  ],
                ),

                Padding(padding: EdgeInsets.only(top: 10)),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[3].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第4张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 3,)));
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[4].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第5张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 4,)));
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[5].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第6张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 5,)));
                      },
                    ),
                  ],
                ),

              ],
            ),
          );
          break;

        case 7:
          return Container(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[0].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第1张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 0,)));
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[1].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第2张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 1,)));
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[2].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第3张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 2,)));
                      },
                    ),
                  ],
                ),

                Padding(padding: EdgeInsets.only(top: 10)),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[3].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第4张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 3,)));
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[4].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第5张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 4,)));
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[5].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第6张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 5,)));
                      },
                    ),
                  ],
                ),

                Padding(padding: EdgeInsets.only(top: 10)),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[6].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第7张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 6,)));
                      },
                    ),
                  ],
                ),

              ],
            ),
          );
          break;

        case 8:
          return Container(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[0].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第1张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 0,)));
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[1].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第2张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 1,)));
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[2].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第3张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 2,)));
                      },
                    ),
                  ],
                ),

                Padding(padding: EdgeInsets.only(top: 10)),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[3].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第4张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 3,)));
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[4].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第5张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 4,)));
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[5].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第6张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 5,)));
                      },
                    ),
                  ],
                ),

                Padding(padding: EdgeInsets.only(top: 10)),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[6].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第7张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 6,)));
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[7].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第8张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 7,)));
                      },
                    ),
                  ],
                ),

              ],
            ),
          );
          break;

        case 9:
          return Container(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[0].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第1张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 0,)));
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[1].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第2张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 1,)));
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[2].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第3张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 2,)));
                      },
                    ),
                  ],
                ),

                Padding(padding: EdgeInsets.only(top: 10)),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[3].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第4张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 3,)));
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[4].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第5张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 4,)));
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[5].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第6张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 5,)));
                      },
                    ),
                  ],
                ),

                Padding(padding: EdgeInsets.only(top: 10)),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[6].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第7张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 6,)));
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[7].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第8张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 7,)));
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: Platform.isIOS ? 100 : 120,
                          width: Platform.isIOS ? 100 : 120,
                          child: Image(image: NetworkImage(resourceList[9].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第9张图片");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhotoView(resourceList: resourceList,initialIndex: 8,)));
                      },
                    ),
                  ],
                ),

              ],
            ),
          );
          break;
        default:
          return Container();
          break;

      }
    }
  }

}