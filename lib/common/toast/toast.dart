
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

ettToast(String message){
  showToast(
    message,
    duration: Duration(seconds: 2),
    position: ToastPosition.center,
    backgroundColor: Colors.black.withOpacity(0.8),
    radius: 3.0,
    textStyle: TextStyle(fontSize: 30.0),
  );
}

