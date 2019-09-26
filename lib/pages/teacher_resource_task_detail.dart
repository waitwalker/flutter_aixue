import 'dart:io';
import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aixue/common/color/color.dart';
import 'package:flutter_aixue/common/network/network_manager.dart';
import 'package:flutter_aixue/common/widgets/audio_player_widget.dart';
import 'package:flutter_aixue/common/widgets/photo_view.dart';
import 'package:flutter_aixue/common/widgets/video_player_widget.dart';
import 'package:flutter_aixue/dao/dao.dart';
import 'package:flutter_aixue/models/teacher_task_detail_model.dart';
import 'package:flutter_aixue/models/teacher_task_model.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


///
/// @name TeacherResourceTaskDetailPage
/// @description 教师学资源任务 原生:文本,图片,视频,音频
/// @author lca
/// @date 2019-09-26
///
class TeacherResourceTaskDetailPage extends StatefulWidget {

  final LastTaskList task;

  TeacherResourceTaskDetailPage(this.task);

  @override
  State<StatefulWidget> createState() {
    return _TeacherResourceTaskDetailState();
  }
}

class _TeacherResourceTaskDetailState extends State<TeacherResourceTaskDetailPage> {
  bool _isLoading = true;
  PDFDocument document;
  LastTaskList task;

  /// 刷新
  RefreshController _refreshController = RefreshController(initialRefresh: true);
  TextEditingController commentController = TextEditingController();

  List<UserReplyList> userReplyList;
  AsyncMemoizer memoizer = AsyncMemoizer();
  Future future;

  @override
  void initState() {
    super.initState();
    task = widget.task;
    //initData();

    future = DaoManager.teacherTaskDetailResourceFetch({
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
            TeacherTaskDetailModel resourceModel = snapshot.data.model;
            if (resourceModel != null) {
              print("$resourceModel");

              userReplyList = resourceModel.data.userReplyList;
              ResourceList resource;
              if (resourceModel.data.resourceList != null && resourceModel.data.resourceList.length > 0) {
                resource = resourceModel.data.resourceList.first;
              }
              return futureDoneChild(resource);
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

  loadDocument() async {
    document = await PDFDocument.fromURL("http://conorlastowka.com/book/CitationNeededBook-Sample.pdf");
    setState(() => _isLoading = false);
  }

  changePDF(value) async {
    setState(() => _isLoading = true);
    if (value == 1) {
      document = await PDFDocument.fromAsset('assets/sample2.pdf');
    } else if (value == 2) {
      document = await PDFDocument.fromURL(
          "http://conorlastowka.com/book/CitationNeededBook-Sample.pdf");
    } else {
      document = await PDFDocument.fromAsset('assets/sample.pdf');
    }
    setState(() => _isLoading = false);
  }

  ///
  /// @Method: initData
  /// @Parameter:
  /// @ReturnType:
  /// @Description: 加载数据
  /// @author: lca
  /// @Date: 2019-08-02
  ///
  initData() async {
    ResponseData responseData = await DaoManager.teacherTaskDetailResourceFetch({
      "jid":"9620132",
      "schoolId":"50043",
      "taskId":"-9357086564067",
      "classId":"1343842",
      "isBoxExists":"1"
    });

    print(responseData);
    if (responseData.result) {
      if (responseData.model != null && responseData.model.result == 1) {
        TeacherTaskDetailModel resourceDocumentModel = responseData.model;
        if (resourceDocumentModel != null) {
          print("$resourceDocumentModel");
          userReplyList = resourceDocumentModel.data.userReplyList;
          setState(() {

          });
          return;
        } else {

        }
      } else {

      }
    } else {

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
        title: Text("学资源"),
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
        title: Text("学资源"),
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
        title: Text("学资源"),
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
  Widget futureDoneChild(ResourceList resource) {
    return Scaffold(
      appBar: AppBar(
        title: Text("学资源-文档"),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios),
          onTap: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Row(
        children: <Widget>[

          /// 左边
          Container(
            width: 0.6 * MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border(right: BorderSide(color: Colors.lightBlue,width: 2.0))
            ),
            child: leftChild(resource),
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
        title: Text("学资源"),
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
  Widget leftChild(ResourceList resource) {
    switch (resource.resourceType) {
      case 1:
        return Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 100)),

            Icon(Icons.mic,size: 100,color: ETTColor.c1_color,),

            Padding(padding: EdgeInsets.only(top: 50)),

            AudioPlayerWidget(url: resource.resourceUrl),

          ],
        );
        break;
      case 2:
        return Padding(
          padding: EdgeInsets.all(10),
          child: Image(
            image: NetworkImage("https://github.com/waitwalker/Resources/blob/master/Flutter/group/flutter_development_0916.JPG?raw=true"),
          ),
        );
        break;
      case 3:
        return VideoPlayerWidget();
        break;
      case 4:
        if (resource.resourceSuffix == ".mp3") {
          //return ijkplayer();
          return Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 100)),

              Icon(Icons.mic,size: 100,color: ETTColor.c1_color,),

              Padding(padding: EdgeInsets.only(top: 50)),

              AudioPlayerWidget(url: resource.resourceUrl),

            ],
          );
        } else {
          loadDocument();
          return _isLoading
              ? Center(child: CircularProgressIndicator())
              : PDFViewer(document: document);
        }
        break;
      default:
        return Container();
        break;
    }
  }


  /// 刷新
  void _onRefresh(RefreshController controller) async {
//    _fetchCourse(currentSubject);
    controller.refreshCompleted();
  }

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
