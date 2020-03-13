//APP内调用api
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;

import 'httpUtil.dart';

class Api {
  // static const env = 'product';
  static const env = 'test';
  // static const env = 'dev';
  static const String BASE_URL = env == 'product'
      ? 'http://user.notary-tech.com'
      : env == 'test'
          ? 'http://user.xuhui_notary.peersafe.cn'
          : 'http://192.168.1.129:1777';
  static getApkUrl() {
    return env == 'product'
        ? 'https://huicunquzheng.oss-cn-shanghai.aliyuncs.com/apk/huicunzheng.product.apk'
        : 'https://huicunquzheng.oss-cn-shanghai.aliyuncs.com/apk/huicunzheng.apk';
  }

  //登录
  static login(Map data, Map header) async {
    var url = BASE_URL + '/api/v1/user/login';
    Response response = await HttpUtil().post(
      url,
      data: data,
      options: Options(
        headers: header,
      ),
    );
    return response.data;
  }

  //退出登录
  static logOut(BuildContext context) async {
    //清空用户信息
    await Api.setLocalUserInfo({});
    Navigator.of(context).pushNamed("login");
  }

  //获取本地用户信息
  static getLocalUserInfo() async {
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + '/' + 'user.db';
    Database database = await openDatabase(path, version: 1);
    var sql = 'SELECT * FROM USERINFO WHERE id = 1';
    var rs = await database.rawQuery(sql);
    // database.close();
    Map userInfo;
    if (rs == null || rs.length == 0) {
      userInfo = {};
    } else {
      userInfo = json.decode(rs[0]['info']);
    }
    return userInfo;
  }

  //更新本地用户信息
  static setLocalUserInfo(Map userInfo) async {
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + '/' + 'user.db';
    Database database = await openDatabase(path, version: 1);
    String sql =
        "REPLACE INTO USERINFO (id,info) VALUES (1,'${jsonEncode(userInfo)}')";
    await database.execute(sql);
  }
    //获取app版本信息
  static Future getAppInfo() async {
    var response = await http.get(
        'https://huicunquzheng.oss-cn-shanghai.aliyuncs.com/apk/huicunzheng.info');
    var info = Utf8Decoder().convert(response.body.codeUnits);
    return jsonDecode(info);
  }
}
