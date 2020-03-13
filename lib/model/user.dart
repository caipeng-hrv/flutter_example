import 'package:flutter/material.dart';

class GlobalData with ChangeNotifier {
  String token;
  String name;
  Map wallet;
  GlobalData({this.token, this.name, this.wallet});
}
