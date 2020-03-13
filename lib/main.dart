import 'package:app/common/init.dart';
import 'package:app/model/user.dart';
import 'package:app/pages/home.dart';
import 'package:app/pages/user/check_version.dart';
import 'package:app/pages/user/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'common/api.dart';
import 'component/cupertino_location.dart';

bool _isLogin = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Init.createDB();
  Map userInfo = await Api.getLocalUserInfo();
  if (userInfo['token'] != null) {
    _isLogin = true;
  }

  PermissionHandler().requestPermissions(<PermissionGroup>[
    PermissionGroup.storage,
    PermissionGroup.camera,
    PermissionGroup.locationWhenInUse,
    PermissionGroup.photos,
    PermissionGroup.microphone
    // 在这里添加需要的权限
  ]);

  GlobalData globalData = GlobalData();
  if(_isLogin){
    globalData.name = userInfo['name'];
    globalData.token = userInfo['token'];
    globalData.wallet = userInfo['wallet'];
  }
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MultiProvider(
    providers: [
      Provider.value(
        value: globalData,
      )],
    child: MyApp(),
  ));
}

//首页
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() {
    return _MyAppStata();
  }
}

class _MyAppStata extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '文旅安全',
      localizationsDelegates: [
        RefreshLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        ChineseCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('zh', 'CH'),
        const Locale('en', 'US'),
        const Locale('zh', ''),
      ],
      routes: <String, WidgetBuilder>{
        "home": (context) => HomePage(),
        "login": (context) => LoginPage(),
      },
      theme: new ThemeData(
        primaryColor: Color(0xFF2779F4),
        backgroundColor: Color(0xFFefeff4),
        // accentColor: Color(0xFF888888),
        textTheme: TextTheme(
          //设置Material的默认字体样式
          body1: TextStyle(color: Color(0xFF45486D), fontSize: 16.0),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: CheckVersionPage(child: _isLogin ? HomePage() : LoginPage()),
    );
  }
}
