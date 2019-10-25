import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_aixue/common/color/color.dart';

///
/// @name SettingPage
/// @description 设置页面
/// @author lca
/// @date 2019-09-23
///
class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingState();
  }
}

class _SettingState extends State<SettingPage> {

  /// 是否点击播放源
  bool isTappedVideoSourceSetting = false;

  /// 是否点击消息设置
  bool isTappedMessageSetting = false;

  /// 是否点击夜间模式
  bool isTappedNightModeSetting = false;

  /// 是否点击关于
  bool isTappedAbout = false;

  /// 是都点击清空缓存
  bool isTappedClearCache = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
      ),
      body: _bodyNormal(),
    );
  }

  ///
  /// @name _bodyNormal
  /// @description 正常normal
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-09-23
  ///
  Widget _bodyNormal() {
    return Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.2),spreadRadius: 3,blurRadius: 3,offset: Offset(0, 3))],
          ),
          width: 0.4 * MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Expanded(child: ListView(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        isTappedVideoSourceSetting = true;
                      });
                      Future.delayed(Duration(seconds: 1),(){
                        isTappedVideoSourceSetting = false;
                        isTappedMessageSetting = false;
                        isTappedNightModeSetting = false;
                        isTappedAbout = false;
                        isTappedClearCache = false;
                      });
                    },
                    child: Container(
                      color: Colors.amber,
                      child: Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(top: 10)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(left: 20),child: Text("视频播放源设置"),),
                              Padding(
                                padding: EdgeInsets.only(right: 15),
                                child: Icon(Icons.keyboard_arrow_right,size: 24,color: ETTColor.c1_color,),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Divider(
                              indent: 15,
                              endIndent: 15,
                              color: ETTColor.c1_color,
                              height: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){},
                    child: Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(left: 20),child: Text("消息设置"),),
                            Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Icon(Icons.keyboard_arrow_right,size: 24,color: ETTColor.c1_color,),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Divider(
                            indent: 15,
                            endIndent: 15,
                            color: ETTColor.c1_color,
                            height: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  GestureDetector(
                    onTap: (){
                    },
                    child: Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(left: 20),child: Text("夜间模式"),),
                            Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Icon(Icons.keyboard_arrow_right,size: 24,color: ETTColor.c1_color,),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Divider(
                            indent: 15,
                            endIndent: 15,
                            color: ETTColor.c1_color,
                            height: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){},
                    child: Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(left: 20),child: Text("关于"),),
                            Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Icon(Icons.keyboard_arrow_right,size: 24,color: ETTColor.c1_color,),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Divider(
                            indent: 15,
                            endIndent: 15,
                            color: ETTColor.c1_color,
                            height: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){

                    },
                    child: Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(left: 20),child: Text("清空缓存"),),
                            Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Row(
                                children: <Widget>[
                                  Text("绑定"),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Icon(Icons.keyboard_arrow_right,size: 24,color: ETTColor.c1_color,),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Divider(
                            indent: 15,
                            endIndent: 15,
                            color: ETTColor.c1_color,
                            height: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),),
            ],
          ),
        ),

        rightContainer(),
      ],
    );
  }

  ///
  /// @name rightContainer
  /// @description 右边容器布局
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-09-23
  ///
  Widget rightContainer() {

    if (isTappedVideoSourceSetting) {
      return Container(
        child: Text("视频播放源"),
      );
    }

    if (isTappedMessageSetting) {
      return Container(
        child: Text("消息设置"),
      );
    }

    if (isTappedNightModeSetting) {
      return Container(
        child: Text("夜间模式"),
      );
    }

    if (isTappedAbout) {
      return Container(
        child: Text("关于"),
      );
    }

    if (isTappedClearCache) {
      return Container(
        child: Text("清空缓存"),
      );
    }

    return Container(
    );
  }
}
