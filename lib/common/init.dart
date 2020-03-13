import 'package:sqflite/sqflite.dart';

//app启动初始化
class Init {
  static createDB() async {
    String databasesPath = await getDatabasesPath();
    String path;
    String sql;
    Database database;

    //当前登录用户信息表
    path = databasesPath + '/' + 'user.db';
    database = await openDatabase(path, version: 1);
    sql =
        'CREATE TABLE IF NOT EXISTS USERINFO ( name TEXT PRIMARY KEY,pwd TEXT,token TEXT,info TEXT,wallet TEXT )';
    await database.execute(sql);
  }
}
