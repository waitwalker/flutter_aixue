import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_aixue/common/color/color.dart';


class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {

    return LoginState();
  }
}

class LoginState extends State<LoginPage> {

  @override
  void initState() {
    super.initState();
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
              child: CupertinoButton(pressedOpacity: 0.5,color: ETTColor.c1_color,child: Text("登录爱学",style: TextStyle(fontSize: 20),), onPressed: (){},),
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
                  CupertinoButton(child: Text("城域网用户?",style: TextStyle(color: Colors.grey),), onPressed: (){}),
                  Row(
                    children: <Widget>[
                      CupertinoButton(child: Text("注册",style: TextStyle(color: ETTColor.c1_color),), onPressed: (){}),
                      CupertinoButton(child: Text("忘记密码?",style: TextStyle(color: ETTColor.c1_color),), onPressed: (){}),
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