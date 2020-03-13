//公共组件
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PublicWidget {
  static showToast(String msg, [ToastGravity location]) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: location == null ? ToastGravity.CENTER : location,
        timeInSecForIos: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.black,
        fontSize: 16.0);
  }
}
