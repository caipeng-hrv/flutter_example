import 'package:app/component/public_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'api.dart';

class HttpUtil {
  get(String url,
      {Map queryParameters, Options options, BuildContext context}) async {
    var dio = _getDefaultDio();
    Response res;
    try {
      res = await dio.get(url,
          queryParameters: queryParameters, options: options);
      return _next(res, context);
    } catch (e) {
      _error(e, context);
    }
  }

  delete(String url,
      {Map queryParameters, Options options, BuildContext context}) async {
    var dio = _getDefaultDio();
    Response res;
    try {
      res = await await dio.delete(url,
          queryParameters: queryParameters, options: options);
      return _next(res, context);
    } catch (e) {
      _error(e, context);
    }
  }

  post(String url, {Map data, Options options, BuildContext context}) async {
    var dio = _getDefaultDio();
    Response res;
    try {
      res = await dio.post(url, data: data, options: options);
      return _next(res, context);
    } catch (e) {
      _error(e, context);
    }
  }

  put(String url, {Map data, Options options, BuildContext context}) async {
    var dio = _getDefaultDio();
    Response res;
    try {
      res = await dio.put(url, data: data, options: options);
      return _next(res, context);
    } catch (e) {
      _error(e, context);
    }
  }

  _getDefaultDio() {
    var dio = Dio();
    dio.options.connectTimeout = 10000;
    return dio;
  }

  //过滤器
  _statusFilter(Response res, BuildContext context) async {
    if (context == null) {
      return 'continue';
    }
    switch (res.statusCode) {
      case 200:
        switch (res.data['code']) {
          case 'tokenErr':
            PublicWidget.showToast('您的账号在其它设备登录');
            await Api.logOut(context);
            break;
          case 'pwdErr':
            PublicWidget.showToast('账户密码已更改');
            // await Api.logOut(context);
            break;
          case 'adminUserDowning':
            PublicWidget.showToast('当前账户已取消管理员权限，请重新登录');
            // await Api.logOut(context);
            break;
          case 'userUpAdmin':
            PublicWidget.showToast('当前账户已升级为管理员，请重新登录');
            // await Api.logOut(context);
            break;
          case 'enterpriseFreeze':
            PublicWidget.showToast('企业已被公证处冻结，请联系相关人员');
            // await Api.logOut(context);
            break;
          case 'userFreeze':
            if (res.data['status'] == 5) {
              PublicWidget.showToast('账号被公证处冻结，请联系相关人员激活');
            } else {
              PublicWidget.showToast('账号被企业管理员冻结，请联系相关人员激活');
            }
            // await Api.logOut(context);
            break;
          case 'adminUserDowning':
            PublicWidget.showToast('当前账户已冻结，请联系相关人员激活');
            // await Api.logOut(context);
            break;
          case 'userDeleted':
            PublicWidget.showToast('当前账户被注销');
            // await Api.logOut(context);
            break;
          default:
            return 'continue';
        }
        break;
      case 401:
        PublicWidget.showToast('token过期,请重新登录');
        // await Api.logOut(context);
        break;
      case 403:
        PublicWidget.showToast('权限不足');
        break;
      case 502:
        PublicWidget.showToast('服务异常');
        break;
      default:
        PublicWidget.showToast('请检查网络');
    }
  }

  _next(Response res, BuildContext context) async {
    var signal = await _statusFilter(res, context);
    if (signal == 'continue') {
      return res;
    }
  }

  _error(e, BuildContext context) {
    if (e.response == null) {
      PublicWidget.showToast('请检查网络');
      return null;
    } else {
      _statusFilter(e.response, context);
    }
  }
}
