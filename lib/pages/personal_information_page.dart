import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_aixue/common/color/color.dart';
import 'package:flutter_aixue/common/network/network_manager.dart';
import 'package:flutter_aixue/dao/dao.dart';
import 'package:flutter_aixue/models/personal_information_model.dart';


class PersonalInformationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PersonState();
  }
}

class _PersonState extends State<PersonalInformationPage> {

  PersonalInformationModel personalInformationModel;

  ///
  /// @Method: initData
  /// @Parameter:
  /// @ReturnType:
  /// @Description: 加载数据
  /// @author: lca
  /// @Date: 2019-08-02
  ///
  initData() async {
    ResponseData responseData = await DaoManager.teacherRecentTaskFetch({"jid":"9620132","schoolId":"50043"});
    print(responseData);
    if (responseData.result) {
      if (responseData.model != null && responseData.model.result == 1) {
        PersonalInformationModel informationModel = responseData.model;
        if (informationModel.data != null) {
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
      body: Row(
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
                                child: Text("aixue"),
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
                                child: Text("9620132"),
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
                    ),
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
                                child: Text("爱学"),
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
                                child: Text("大连910分校"),
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
      ),
    );
  }
}
