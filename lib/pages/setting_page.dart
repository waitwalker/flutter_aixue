import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_aixue/common/color/color.dart';


class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingState();
  }
}

class _SettingState extends State<SettingPage> {
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
                    onTap: (){},
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
    if (isTappedBindPhone) {
      if (isCanBind) {
        return Container(
          width: 0.6 * MediaQuery.of(context).size.width,
        );
      } else {
        return Container(
          width: 0.6 * MediaQuery.of(context).size.width,
        );
      }
    } else {
      if (isTappedChangePassword) {
        return Container(
          width: 0.6 * MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 20),),
              Padding(
                padding: EdgeInsets.only(left: 20,right: 20,),
                child: Container(
                  child: CupertinoTextField(
                    controller: firstController,
                    placeholder: "请输入原密码",
                    clearButtonMode: OverlayVisibilityMode.editing,
                    obscureText: isFirstSecurity,
                    prefix: Padding(padding: EdgeInsets.only(left: 10),child: Text("原密码"),),

                    suffix: IconButton(
                      onPressed: (){
                        setState(() {
                          isFirstSecurity = !isFirstSecurity;
                        });
                      },
                      icon: Icon(Icons.security),
                    ),
                    onTap: (){

                    },
                    onChanged: (text){

                    },
                    onSubmitted: (text){

                    },
                    onEditingComplete: (){

                    },

                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20),),
              Padding(
                padding: EdgeInsets.only(left: 20,right: 20,),
                child: Container(
                  child: CupertinoTextField(
                    controller: secondController,
                    placeholder: "请输入新密码",
                    clearButtonMode: OverlayVisibilityMode.editing,
                    obscureText: isSecondSecurity,
                    prefix: Padding(padding: EdgeInsets.only(left: 10),child: Text("新密码"),),

                    suffix: IconButton(
                      onPressed: (){
                        setState(() {
                          isSecondSecurity = !isSecondSecurity;
                        });
                      },
                      icon: Icon(Icons.security),
                    ),
                    onTap: (){

                    },
                    onChanged: (text){

                    },
                    onSubmitted: (text){

                    },
                    onEditingComplete: (){

                    },

                  ),
                ),
              ),

              Padding(padding: EdgeInsets.only(top: 20),),

              Padding(
                padding: EdgeInsets.only(left: 20,right: 20),
                child: Container(
                  width: 0.6 * MediaQuery.of(context).size.width - 40,
                  child: RaisedButton(
                    onPressed: (){},
                    child: Text("确认"),
                  ),
                ),
              ),

            ],
          ),
        );
      } else {
        return Container(
          width: 0.6 * MediaQuery.of(context).size.width,
        );
      }
    }
  }
}
