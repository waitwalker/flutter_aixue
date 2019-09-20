import 'package:easy_dialog/easy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_aixue/common/color/color.dart';
import 'package:flutter_aixue/common/network/network_manager.dart';
import 'package:flutter_aixue/dao/dao.dart';
import 'package:flutter_aixue/models/personal_information_model.dart';

///
/// @name PersonalInformationPage
/// @description 个人信息
/// @author lca
/// @date 2019-09-20
///
class PersonalInformationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PersonState();
  }
}

class _PersonState extends State<PersonalInformationPage> {

  PersonalInformationModel personalInformationModel;

  bool isLoading = true;

  ///
  /// @Method: initData
  /// @Parameter:
  /// @ReturnType:
  /// @Description: 加载数据
  /// @author: lca
  /// @Date: 2019-08-02
  ///
  initData() async {
    ResponseData responseData = await DaoManager.personalInformationFetch({
      "userJid":"9620132",
      "friendJid":"9620132",
      "flag":"1"
    });
    print(responseData);
    if (responseData.result) {
      if (responseData.model != null && responseData.model.result == 1) {
        PersonalInformationModel informationModel = responseData.model;
        if (informationModel.data != null) {
          isLoading = false;
          setState(() {
            personalInformationModel = informationModel;
          });
        } else {

        }
      } else {

      }
    } else {

    }
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("个人信息"),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return _bodyNormal();
    }
  }

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
                      EasyDialog(
                        title: Text("修改头像"),
                        height: 200,
                          contentList: [
                            Column(
                              children: <Widget>[
                                Container(
                                  width: 300,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(2),
                                    boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.2),spreadRadius: 3,blurRadius: 3,offset: Offset(0, 3))],
                                  ),
                                  child: FlatButton(
                                    padding: EdgeInsets.only(top: 8.0),
                                    textColor: Colors.lightBlue,
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: new Text("相机",),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top: 20)),
                                Container(
                                  width: 300,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(2),
                                    boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.2),spreadRadius: 3,blurRadius: 3,offset: Offset(0, 3))],
                                  ),
                                  child: FlatButton(
                                    padding: EdgeInsets.only(top: 8.0),
                                    textColor: Colors.lightBlue,
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: new Text("相册",),
                                  ),
                                ),
                              ],
                            ),
                          ],
                      ).show(context);
                    },
                    child: Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 20)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(left: 20),child: Text("头像"),),
                            Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.2),spreadRadius: 3,blurRadius: 3,offset: Offset(0, 3))],
                                    ),
                                    child: Image(image: personalInformationModel.data.uPhoto == null ?  AssetImage("lib/resources/images/1024.png") : NetworkImage(personalInformationModel.data.uPhoto)),
                                  ),
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
                  GestureDetector(
                    onTap: (){},
                    child: Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(left: 20),child: Text("用户名"),),
                            Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Text(personalInformationModel.data.nickName == null ? "爱学" : personalInformationModel.data.nickName),
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
                            Padding(padding: EdgeInsets.only(left: 20),child: Text("用户id"),),
                            Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Text(personalInformationModel.data.jid == null ? "10000" : "${personalInformationModel.data.jid}"),
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
                  _phoneNumWidget(),

                  GestureDetector(
                    onTap: (){},
                    child: Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(left: 20),child: Text("修改密码"),),
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
                            Padding(padding: EdgeInsets.only(left: 20),child: Text("真实姓名"),),
                            Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Text(personalInformationModel.data.uName == null ? "爱学" : personalInformationModel.data.uName),
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
                            Padding(padding: EdgeInsets.only(left: 20),child: Text("所在学校"),),
                            Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Text(personalInformationModel.data.schoolName == null ? "爱学总校" : personalInformationModel.data.schoolName),
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
      ],
    );
  }

  ///
  /// @name _phoneNumWidget
  /// @description 手机号控件
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-09-20
  ///
  Widget _phoneNumWidget() {
    if (personalInformationModel.data.phone != null && personalInformationModel.data.phone.length > 0) {
      return GestureDetector(
        onTap: (){},
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(left: 20),child: Text("手机号"),),
                Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Text("${personalInformationModel.data.phone}"),
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
      );
    } else {
      return GestureDetector(
        onTap: (){},
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(left: 20),child: Text("手机号"),),
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
      );
    }
  }

}
