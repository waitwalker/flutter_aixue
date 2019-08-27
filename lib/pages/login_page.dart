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
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                  boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.6),blurRadius: 4,offset: Offset(0, 2))]
              ),
              child: CupertinoButton(color: ETTColor.c1_color,child: Text("登录爱学"), onPressed: (){},),
            ),
          ),

        ],
      ),

    );
  }
}