import 'package:flutter/material.dart';

//快速创建一个新页面，复制，然后替换Example
class ExamplePage extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<ExamplePage> {
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
