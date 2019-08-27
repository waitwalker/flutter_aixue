import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {

    return null;
  }
}

class LoginState extends State<LoginPage> {
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
    );
  }
}