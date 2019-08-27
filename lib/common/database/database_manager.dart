import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String kTableName = 'recognized';
final String kRecognizeId = "_id";/// id
final String kRecognizeType = "识别类型"; /// 识别类型
final String kRecognizeTypeName = "识别类型名称"; /// 识别类型名称
final String kRecognizeContent = "识别内容"; /// 识别内容
final String kRecognizeTime = "识别时间"; /// 识别时间

class DataBaseManager {

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
  Future<RecognizeModel> insert(RecognizeModel recognizeModel) async {
    recognizeModel.recognizeId = await db.insert(kTableName, recognizeModel.toMap());
    return recognizeModel;
  }

  /// 查询所有数据
  Future<List<RecognizeModel>> queryAll() async {
    List<Map> maps = await db.query(kTableName,columns: [
      kRecognizeId,
      kRecognizeType,
      kRecognizeTypeName,
      kRecognizeContent,
      kRecognizeTime
    ]);

    if (maps == null || maps.length == 0) return null;

    List<RecognizeModel> models = [];
    for(int i = 0; i < maps.length; i++) {
      models.add(RecognizeModel.fromMap(maps[i]));
    }
    return models;
  }

  /// 根据id 查找
  Future<RecognizeModel> query(int id) async {
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
      return RecognizeModel.fromMap(maps.first);
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
  Future<int> update(RecognizeModel recognizeModel) async {
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

class RecognizeModel {
  int recognizeId; /// id
  int recognizeType; /// 识别类型
  String recognizeTypeName; /// 识别类型名称
  String recognizeContent; /// 识别内容
  String recognizeTime; /// 识别时间
  bool isSelected = false;
  int currentIndex = 0;

  /// 构造
  RecognizeModel({
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
  RecognizeModel.fromMap(Map<String,dynamic> map) {
    recognizeId = map[kRecognizeId];
    recognizeType = map[kRecognizeType];
    recognizeTypeName = map[kRecognizeTypeName];
    recognizeContent = map[kRecognizeContent];
    recognizeTime = map[kRecognizeTime];
  }


}