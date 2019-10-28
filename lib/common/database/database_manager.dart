import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String kTableName = 'recognized';
final String kRecognizeId = "_id";/// id
final String kRecognizeType = "识别类型"; /// 识别类型
final String kRecognizeTypeName = "识别类型名称"; /// 识别类型名称
final String kRecognizeContent = "识别内容"; /// 识别内容
final String kRecognizeTime = "识别时间"; /// 识别时间


/// 登录相关字段
final String kLoginTableName = "Login_Table"; ///登录表名称
final String kId = "_id"; /// id
final String kJid = "jid"; /// jid
final String kLoginType = "login_type"; ///登录类型
final String kAccount = "login_account"; ///登录账号
final String kPassword = "login_password"; ///登录密码
final String kLastLoginTime = "last_login_time"; ///上次登录时间
final String kCurrentLoginTime = "current_login_time"; ///本次登录时间
/// 其他字段待加








///
/// @name DataBaseManager
/// @description 本地持久化管理类
/// @author lca
/// @date 2019-10-28
///
class DataBaseManager {

  ///
  /// @name instance
  /// @description 单例模式
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-10-28
  ///
  static final DataBaseManager instance = DataBaseManager.internal();
  factory DataBaseManager() {
    return instance;
  }
  DataBaseManager.internal();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDatabase();
    return _database;
  }

  ///
  /// @name initDatabase
  /// @description 初始化数据库
  /// @parameters
  /// @return
  /// @author lca
  /// @date 2019-10-28
  ///
  initDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath,"flutter_aixue.db");
    var _db = await openDatabase(path,version: 1, onCreate: (Database db, int version) async {

      /// 创建登录表
      await db.execute('''
          CREATE TABLE $kLoginTableName (
            $kId INTEGER PRIMARY KEY, 
            $kJid TEXT, 
            $kLoginType INTEGER,
            $kAccount TEXT, 
            $kPassword TEXT,
            $kLastLoginTime TEXT, 
            $kCurrentLoginTime TEXT)
          ''');
    });
    return _db;
  }



  Database db;
  /// 打开数据库
  open() async{
    var databasePath = await getDatabasesPath();
    String fullPath = join(databasePath,"recognize.db");

    db = await openDatabase(fullPath,version: 1,onCreate: (Database database, int version) async {
      await database.execute('''
          CREATE TABLE $kTableName (
            $kRecognizeId INTEGER PRIMARY KEY, 
            $kRecognizeType INTEGER, 
            $kRecognizeTypeName TEXT, 
            $kRecognizeContent TEXT, 
            $kRecognizeTime TEXT)
          ''');
    });
  }

  /// 插入数据
  Future<LoginDatabaseModel> insert(LoginDatabaseModel recognizeModel) async {
    recognizeModel.recognizeId = await db.insert(kTableName, recognizeModel.toMap());
    return recognizeModel;
  }

  /// 查询所有数据
  Future<List<LoginDatabaseModel>> queryAll() async {
    List<Map> maps = await db.query(kTableName,columns: [
      kRecognizeId,
      kRecognizeType,
      kRecognizeTypeName,
      kRecognizeContent,
      kRecognizeTime
    ]);

    if (maps == null || maps.length == 0) return null;

    List<LoginDatabaseModel> models = [];
    for(int i = 0; i < maps.length; i++) {
      models.add(LoginDatabaseModel.fromMap(maps[i]));
    }
    return models;
  }

  /// 根据id 查找
  Future<LoginDatabaseModel> query(int id) async {
    List<Map> maps = await db.query(kTableName,
        columns: [
          kRecognizeId,
          kRecognizeType,
          kRecognizeTypeName,
          kRecognizeContent,
          kRecognizeTime
        ],
        where: '$kRecognizeId = ?', whereArgs: [id]);
    if (maps.length > 0) {
      return LoginDatabaseModel.fromMap(maps.first);
    }
    return null;
  }

  /// 删除所有
  Future<Null> deleteAll() async {
    await db.delete(kTableName,where: '$kRecognizeId > 0');
  }

  /// 根据id 删除
  Future<int> delete(int id) async {
    return await db.delete(kTableName,where: '$kRecognizeId = ?',whereArgs: [id]);
  }

  /// 更新
  Future<int> update(LoginDatabaseModel recognizeModel) async {
    return await db.update(
        kTableName,
        recognizeModel.toMap(),
        where: '$kRecognizeId = ?',
        whereArgs: [recognizeModel.recognizeId]);
  }

  /// 关闭数据库
  close() async {
    await db.close();
  }

}

///
/// @name 登录数据库模型
/// @description 
/// @author lca
/// @date 2019-10-28
///
class LoginDatabaseModel {
  int recognizeId; /// id
  int recognizeType; /// 识别类型
  String recognizeTypeName; /// 识别类型名称
  String recognizeContent; /// 识别内容
  String recognizeTime; /// 识别时间
  bool isSelected = false;
  int currentIndex = 0;

  /// 构造
  LoginDatabaseModel({
    this.recognizeId,
    this.recognizeType,
    this.recognizeTypeName,
    this.recognizeContent,
    this.recognizeTime});

  /// 转字典
  Map<String,dynamic> toMap() {
    var map = <String,dynamic>{
      kRecognizeType:recognizeType,
      kRecognizeTypeName:recognizeTypeName,
      kRecognizeContent:recognizeContent,
      kRecognizeTime:recognizeTime,
    };
    if (recognizeId != null) {
      map[kRecognizeId] = recognizeId;
    }
    return map;
  }

  /// 转模型
  LoginDatabaseModel.fromMap(Map<String,dynamic> map) {
    recognizeId = map[kRecognizeId];
    recognizeType = map[kRecognizeType];
    recognizeTypeName = map[kRecognizeTypeName];
    recognizeContent = map[kRecognizeContent];
    recognizeTime = map[kRecognizeTime];
  }
}
