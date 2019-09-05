import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_aixue/common/color/color.dart';
import 'package:flutter_aixue/common/network/network_manager.dart';
import 'package:flutter_aixue/dao/dao.dart';
import 'package:flutter_aixue/models/teacher_resource_document_model.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:webview_flutter/webview_flutter.dart';



class TeacherResourceTaskDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TeacherResourceTaskDetailState();
  }
}

class _TeacherResourceTaskDetailState extends State<TeacherResourceTaskDetailPage> {
  bool _isLoading = true;
  PDFDocument document;

  /// 刷新
  RefreshController _refreshController = RefreshController(initialRefresh: true);

  List<UserReplyList> userReplyList;

  @override
  void initState() {
    super.initState();
    loadDocument();
    initData();
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
    ResponseData responseData = await DaoManager.teacherResourceDocumentFetch({
      "jid":"9620132",
      "schoolId":"50043",
      "taskId":"-9357086564067",
      "classId":"1343842",
      "isBoxExists":"1"
    });

    print(responseData);
    if (responseData.result) {
      if (responseData.model != null && responseData.model.result == 1) {
        TeacherResourceDocumentModel resourceDocumentModel = responseData.model;
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
      body: Row(
        children: <Widget>[
          Container(
            width: 0.6 * MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border(right: BorderSide(color: Colors.lightBlue,width: 2.0))
            ),
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : PDFViewer(document: document),
          ),

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

                    },
                  ),
                ),
              ],
            ),

            Padding(padding: EdgeInsets.only(top: 15)),

//          Expanded(child: StaggeredGridView.countBuilder(
//            physics: NeverScrollableScrollPhysics(),
//            crossAxisCount: 6,
//            itemCount: 9,
//            mainAxisSpacing: 10,
//            crossAxisSpacing: 10,
//            itemBuilder: _imagesItemBuilder,
//            staggeredTileBuilder: (int index){
//              return StaggeredTile.fit(2);
//            },),),

          ],
        ),
      ),
    );
  }

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
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[0].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第1张图片");
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
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[0].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第1张图片");
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[1].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第2张图片");
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
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[0].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第1张图片");
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[1].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第2张图片");
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[2].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第3张图片");
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
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[0].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第1张图片");
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[1].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第2张图片");
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[2].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第3张图片");
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
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[3].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第4张图片");
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
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[0].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第1张图片");
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[1].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第2张图片");
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[2].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第3张图片");
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
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[3].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第4张图片");
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[4].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第5张图片");
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
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[0].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第1张图片");
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[1].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第2张图片");
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[2].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第3张图片");
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
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[3].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第4张图片");
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[4].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第5张图片");
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[5].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第6张图片");
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
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[0].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第1张图片");
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[1].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第2张图片");
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[2].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第3张图片");
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
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[3].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第4张图片");
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[4].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第5张图片");
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[5].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第6张图片");
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
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[6].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第7张图片");
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
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[0].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第1张图片");
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[1].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第2张图片");
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[2].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第3张图片");
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
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[3].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第4张图片");
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[4].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第5张图片");
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[5].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第6张图片");
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
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[6].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第7张图片");
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[7].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第8张图片");
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
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[0].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第1张图片");
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[1].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第2张图片");
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[2].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第3张图片");
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
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[3].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第4张图片");
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[4].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第5张图片");
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[5].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第6张图片");
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
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[6].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第7张图片");
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[7].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第8张图片");
                      },
                    ),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: Container(
                          height: 120,
                          width: 120,
                          child: Image(image: NetworkImage(resourceList[9].resourceUrl),),
                        ),
                      ),
                      onTap: (){
                        print("当前图片被点击:第$currentSection item,第9张图片");
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

  Widget _imagesItemBuilder(BuildContext context, int index) {
    return Container(
      color: Colors.amberAccent,
      child: Text("$index"),
    );
  }





//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: Scaffold(
//        drawer: Drawer(
//          child: Column(
//            children: <Widget>[
//              SizedBox(height: 36),
//              ListTile(
//                title: Text('Load from Assets'),
//                onTap: () {
//                  changePDF(1);
//                },
//              ),
//              ListTile(
//                title: Text('Load from URL'),
//                onTap: () {
//                  changePDF(2);
//                },
//              ),
//              ListTile(
//                title: Text('Restore default'),
//                onTap: () {
//                  changePDF(3);
//                },
//              ),
//            ],
//          ),
//        ),
//        appBar: AppBar(
//          title: const Text('FlutterPluginPDFViewer'),
//        ),
//        body: Center(
//            child: _isLoading
//                ? Center(child: CircularProgressIndicator())
//                : PDFViewer(document: document)),
//      ),
//    );
//  }
}