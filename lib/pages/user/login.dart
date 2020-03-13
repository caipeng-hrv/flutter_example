import 'package:flutter/material.dart';

//快速创建一个新页面，复制，然后替换Login
class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  TextEditingController _text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: Container(
          child: new Text(
            '忘记密码',
            style: new TextStyle(
              color: Color(0xFFFFFFFF),
              // letterSpacing: 20,
              fontSize: 16,
            ),
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.bottomLeft,
        child: new Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}
