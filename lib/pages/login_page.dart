import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_aixue/common/color/color.dart';
import 'package:flutter_aixue/common/singleton/singleton_manager.dart';
import 'package:flutter_aixue/dao/dao.dart';
import 'package:flutter_aixue/pages/home_page.dart';


///
/// @name LoginPage
/// @description 登录页
/// @author lca
/// @date 2019-10-15
///
class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginPage> {

  TextEditingController accountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool accountValued = false;
  bool passwordValued = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("lib/resources/images/login_bg.png"),
        )
      ),

      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 72),
            child: Image(image: AssetImage("lib/resources/images/common_portrait.png"),width: 110,height: 110,),
          ),

          Padding(padding: EdgeInsets.only(top: 40),
            child: Container(
              height: 60,
              width: 420,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(2)),
                boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.6),blurRadius: 4,offset: Offset(0, 2))]
              ),
              child: CupertinoTextField(
                controller: accountController,
                placeholder: "手机号/用户名/邮箱",
                placeholderStyle: TextStyle(fontSize: 16,color: ETTColor.g4_color),
                prefix: Padding(padding: EdgeInsets.only(left: 24,right: 8),
                  child: Image(image: AssetImage("lib/resources/images/login_user.png",),width: 24,height: 24,),
                ),
                clearButtonMode: OverlayVisibilityMode.editing,
                style: TextStyle(fontSize: 18,color: ETTColor.g4_color),
                decoration: BoxDecoration(

                ),

                onTap: (){

                  /// 1.
                  print("account onTap:${accountController.text}");
                  accountValued = accountController.text.length > 0 ? true : false;
                },

                onChanged: (text){

                  /// 2.
                  print("account onchanged:$text");
                  accountValued = text.length > 0 ? true : false;
                },

                onEditingComplete: (){

                  /// 3.
                  print("account onEditingComplete:${accountController.text}");
                  accountValued = accountController.text.length > 0 ? true : false;
                },

                onSubmitted: (text){

                  /// 4.
                  accountValued = text.length > 0 ? true : false;
                },
              ),
            ),
          ),

          Padding(padding: EdgeInsets.only(top: 16),
            child: Container(
              height: 60,
              width: 420,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                  boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.6),blurRadius: 4,offset: Offset(0, 2))]
              ),
              child: CupertinoTextField(
                controller: passwordController,
                placeholder: "密码",
                placeholderStyle: TextStyle(fontSize: 16,color: ETTColor.g4_color),
                prefix: Padding(padding: EdgeInsets.only(left: 24,right: 8),
                  child: Image(image: AssetImage("lib/resources/images/login_password.png",),width: 24,height: 24,),
                ),
                clearButtonMode: OverlayVisibilityMode.editing,
                style: TextStyle(fontSize: 18,color: ETTColor.g4_color),
                obscureText: true,
                decoration: BoxDecoration(

                ),

                onTap: (){

                  /// 1.
                  print("password onTap:${passwordController.text}");
                  passwordValued = passwordController.text.length > 0 ? true : false;
                },

                onChanged: (text){

                  /// 2.
                  print("password onchanged:$text");
                  passwordValued = text.length > 0 ? true : false;
                },

                onEditingComplete: (){

                  /// 3.
                  print("password onEditingComplete:${passwordController.text}");
                  passwordValued = passwordController.text.length > 0 ? true : false;
                },

                onSubmitted: (text){

                  /// 4.
                  passwordValued = text.length > 0 ? true : false;
                },
              ),
            ),
          ),

          Padding(padding: EdgeInsets.only(top: 16),
            child: Container(
              height: 60,
              width: 420,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                  boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.6),blurRadius: 4,offset: Offset(0, 2))]
              ),
              child: CupertinoButton(
                pressedOpacity: 0.5,
                color: ETTColor.c1_color,
                disabledColor: Color.fromRGBO(74, 172, 238, 0.5),
                child: Text("登录爱学",style: TextStyle(fontSize: 20),),
                onPressed: (accountValued && passwordValued) ? () async {

                  Map <String, String> para = {"uName":accountController.text,"pwd":passwordController.text};
                  var response = await DaoManager.loginFetch(para);
                  if (response.result && response.model != null && SingletonManager.sharedInstance.loginModel != null) {
                    if (SingletonManager.sharedInstance.loginModel.result == 1) {
                      print("登录成功");
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return HomePage();
                      }));
                    } else {
                      print("登录异常:${SingletonManager.sharedInstance.loginModel.msg}");
                    }
                  } else {
                    print("登录异常,请稍候重试");
                  }
                  print(response);
                } : null,),
            ),
          ),

          Padding(padding: EdgeInsets.only(top: 12),
            child: Container(
              height: 50,
              width: 420,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CupertinoButton(
                    pressedOpacity: 0.7,
                    child: Text("城域网用户?",style: TextStyle(color: Colors.grey),),
                    onPressed: (){
                      showDialog(context: context,builder: (context){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 400,
                              height: 400,
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      CupertinoButton(child: Icon(Icons.cancel,size: 24,color: Colors.grey,), onPressed: (){
                                        Navigator.of(context).pop();
                                      },),
                                    ],
                                  ),

                                  Padding(padding: EdgeInsets.only(top: 8,),
                                    child: Container(
                                      width: 400,
                                      height: 300,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(padding: EdgeInsets.only(left: 20,top: 20),
                                            child: Text("选择城域网",style: TextStyle(fontSize: 18,color: Colors.grey,decoration: TextDecoration.none),),
                                          ),


                                          Padding(padding: EdgeInsets.only(left: 20,top: 60),
                                            child: Container(
                                              height: 60,
                                              width: 360,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.6),offset: Offset(2,2),blurRadius: 5)]
                                              ),
                                              child: CupertinoButton(
                                                pressedOpacity: 0.5,
                                                child: Text("东莞",style: TextStyle(fontSize: 18,color: Colors.black,decoration: TextDecoration.none),),
                                                onPressed: (){

                                                },
                                              ),
                                            ),
                                          ),
                                          Padding(padding: EdgeInsets.only(left: 20,top: 30),
                                            child: Container(
                                              height: 60,
                                              width: 360,
                                              decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.6),offset: Offset(2,2),blurRadius: 5)]
                                              ),
                                              child: CupertinoButton(
                                                color: ETTColor.c1_color,
                                                pressedOpacity: 0.5,
                                                child: Text("我不是",style: TextStyle(fontSize: 18,color: Colors.white,decoration: TextDecoration.none),),
                                                onPressed: (){

                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        );
                      });
                    },
                  ),
                  Row(
                    children: <Widget>[
                      CupertinoButton(pressedOpacity: 0.7,child: Text("注册",style: TextStyle(color: ETTColor.c1_color),), onPressed: (){

                      }),
                      CupertinoButton(pressedOpacity: 0.7,child: Text("忘记密码?",style: TextStyle(color: ETTColor.c1_color),), onPressed: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return DialogContent();
                        }));
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Padding(padding: EdgeInsets.only(top: 32),
            child: Container(
              height: 30,
              width: 420,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(height: 1,width: 80,color: Colors.grey,),

                  Padding(padding: EdgeInsets.only(left: 16)),

                  Text("或使用以下方式登录",style: TextStyle(fontSize: 16,color: Colors.grey,decoration: TextDecoration.none),),

                  Padding(padding: EdgeInsets.only(left: 16)),

                  Container(height: 1,width: 80,color: Colors.grey,),
                ],
              ),
            ),
          ),

          Padding(padding: EdgeInsets.only(top: 24),
            child: Container(
              height: 64,
              width: 420,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 64,
                    width: 64,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.white,
                      boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.6),blurRadius: 4,offset: Offset(0, 2)),],
                    ),
                    child: CupertinoButton(pressedOpacity: 0.8,child: Image(image: AssetImage("lib/resources/images/login_other_qq.png")), onPressed: (){}),
                  ),

                  Padding(padding: EdgeInsets.only(left: 64)),

                  Container(
                    height: 64,
                    width: 64,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.white,
                      boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.6),blurRadius: 4,offset: Offset(0, 2)),],
                    ),
                    child: CupertinoButton(pressedOpacity: 0.8,child: Image(image: AssetImage("lib/resources/images/login_other_weixin.png")), onPressed: (){}),
                  ),

                  Padding(padding: EdgeInsets.only(left: 64)),

                  Container(
                    height: 64,
                    width: 64,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.white,
                      boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.6),blurRadius: 4,offset: Offset(0, 2)),],
                    ),
                    child: CupertinoButton(pressedOpacity: 0.8,child: Image(image: AssetImage("lib/resources/images/login_other_weibo.png")), onPressed: (){}),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),

    );
  }
}

class DialogContent extends StatefulWidget {
  DialogContent({Key key,}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DialogContentState();
}

class DialogContentState extends State<DialogContent> {

  TextEditingController phoneController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  Timer _timer;
  int _seconds = 60;
  String _countdownTitle = "获取验证码";

  String _nextStepTitle = "下一步";

  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {

    if (_timer == null) {
      _timer.cancel();
    }
    super.dispose();
  }


  _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer){
      if (_seconds == 0) {
        _timer.cancel();
        _countdownTitle = "获取验证码";
        _seconds = 60;
        setState(() {
        });
        return;
      }
      _seconds --;
      _countdownTitle = "$_seconds" + "s";
      print("验证码倒计时:$_countdownTitle");

      setState(() {
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(
          image: AssetImage("lib/resources/images/login_bg.png"),
        ),
      ),
      child: Container(
        color: Color.fromRGBO(0, 0, 0, 0.3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 400,
              height: 430,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      CupertinoButton(child: Icon(Icons.cancel,size: 24,color: Colors.grey,), onPressed: (){
                        if (_timer != null) {
                          _timer.cancel();
                          _seconds = 60;
                          _countdownTitle = "获取验证码";
                        }
                        if (_nextStepTitle == "下一步") {
                          Navigator.of(context).pop();
                        } else {
                          _nextStepTitle = "下一步";
                          setState(() {

                          });
                        }
                      },),
                    ],
                  ),

                  Padding(padding: EdgeInsets.only(top: 8,),
                    child: Container(
                      width: 400,
                      height: 340,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(left: 20,top: 20),
                            child: Text("输入注册时的手机号",style: TextStyle(fontSize: 15,color: Colors.grey,decoration: TextDecoration.none),),
                          ),

                          phoneContainer(),

                          Padding(padding: EdgeInsets.only(left: 20,top: 30),
                            child: Container(
                              height: 60,
                              width: 360,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(8.0),
                                  boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.6),offset: Offset(2,2),blurRadius: 5)]
                              ),
                              child: CupertinoButton(
                                color: ETTColor.c1_color,
                                pressedOpacity: 0.5,
                                child: Text(_nextStepTitle,style: TextStyle(fontSize: 18,color: Colors.white,decoration: TextDecoration.none),),
                                onPressed: (){
                                  if (_nextStepTitle == "下一步") {
                                    _nextStepTitle = "确认";
                                    if (_timer != null) {
                                      _timer.cancel();
                                      _seconds = 60;
                                      _countdownTitle = "获取验证码";
                                    }
                                    setState(() {

                                    });
                                  } else {

                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///
  /// @name phoneContainer
  /// @description 手机号容器
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-10-16
  ///
  Widget phoneContainer() {
    if (_nextStepTitle == "下一步") {
      return Padding(padding: EdgeInsets.only(left: 20,top: 40),
        child: Container(
          height: 120,
          width: 360,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(2)),
              boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.6),blurRadius: 4,offset: Offset(0, 2))]
          ),
          child: Container(
            width: 360,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 59.5,
                  child: CupertinoTextField(
                    controller: phoneController,
                    placeholder: "手机号",
                    placeholderStyle: TextStyle(fontSize: 16,color: ETTColor.g4_color),
                    prefix: Padding(padding: EdgeInsets.only(left: 24,right: 8),
                      child: Image(image: AssetImage("lib/resources/images/login_phone.png",),width: 24,height: 24,),
                    ),
                    clearButtonMode: OverlayVisibilityMode.editing,
                    style: TextStyle(fontSize: 18,color: ETTColor.g4_color),
                    decoration: BoxDecoration(

                    ),
                  ),
                ),

                Container(
                  height: 1,
                  color: Colors.grey,
                ),

                Container(
                  height: 59.5,
                  width: 360,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 260,
                        child: CupertinoTextField(
                          controller: codeController,
                          placeholder: "验证码",
                          placeholderStyle: TextStyle(fontSize: 16,color: ETTColor.g4_color),
                          prefix: Padding(padding: EdgeInsets.only(left: 24,right: 8),
                            child: Image(image: AssetImage("lib/resources/images/login_idcode.png",),width: 24,height: 24,),
                          ),
                          clearButtonMode: OverlayVisibilityMode.editing,
                          style: TextStyle(fontSize: 18,color: ETTColor.g4_color),
                          decoration: BoxDecoration(

                          ),
                        ),
                      ),
                      OutlineButton(
                        borderSide: BorderSide(color: _seconds > 0 ? ETTColor.c1_color : ETTColor.g4_color,width: 1.0),
                        child: Text(_countdownTitle,style: TextStyle(fontSize: 12,color: _seconds == 60 ? ETTColor.c1_color : ETTColor.g4_color),),
                        onPressed: _seconds != 60 ? null : (){
                          _startTimer();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Padding(padding: EdgeInsets.only(left: 20,top: 40),
        child: Container(
          height: 120,
          width: 360,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(2)),
              boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.6),blurRadius: 4,offset: Offset(0, 2))]
          ),
          child: Container(
            width: 360,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 59.5,
                  child: CupertinoTextField(
                    controller: phoneController,
                    placeholder: "手机号",
                    placeholderStyle: TextStyle(fontSize: 16,color: ETTColor.g4_color),
                    prefix: Padding(padding: EdgeInsets.only(left: 24,right: 8),
                      child: Image(image: AssetImage("lib/resources/images/login_phone.png",),width: 24,height: 24,),
                    ),
                    clearButtonMode: OverlayVisibilityMode.editing,
                    style: TextStyle(fontSize: 18,color: ETTColor.g4_color),
                    decoration: BoxDecoration(

                    ),
                  ),
                ),

                Container(
                  height: 1,
                  color: Colors.grey,
                ),

                Container(
                  height: 59.5,
                  child: CupertinoTextField(
                    controller: phoneController,
                    placeholder: "手机号",
                    placeholderStyle: TextStyle(fontSize: 16,color: ETTColor.g4_color),
                    prefix: Padding(padding: EdgeInsets.only(left: 24,right: 8),
                      child: Image(image: AssetImage("lib/resources/images/login_phone.png",),width: 24,height: 24,),
                    ),
                    clearButtonMode: OverlayVisibilityMode.editing,
                    style: TextStyle(fontSize: 18,color: ETTColor.g4_color),
                    decoration: BoxDecoration(

                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }



}