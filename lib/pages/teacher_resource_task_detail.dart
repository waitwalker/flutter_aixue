import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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

  @override
  void initState() {
    super.initState();
    loadDocument();
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
                      itemCount: 50,
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
    return Container(
      child: Column(
        children: <Widget>[
          Text("$index"),

          Container(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 30,top: 20),
                      child: Container(
                        color: Colors.amberAccent,
                        child: Text("1"),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 30,top: 20),
                      child: Text("2"),
                    ),
                    Padding(padding: EdgeInsets.only(left: 30,top: 20,right: 30),
                      child: Text("3"),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Padding(padding: EdgeInsets.only(top: 30)),

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
    );
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
