import 'dart:async';

import 'package:ezberci/models/user/text/text.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    var dbFolder = await getDatabasesPath();
    String path = join(dbFolder, "Contact.db");

    return await openDatabase(path, onCreate: _onCreate, version: 1);
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE Yazilar(id INTEGER PRIMARY KEY, baslik TEXT, metin TEXT)");
  }

  Future<List<UserText>> getUserTexts() async {
    var dbClient = await db;

    var result = await dbClient.query('Yazilar', orderBy: 'baslik');

    return result.map((data) => UserText.fromObject(data)).toList();
  }

  Future<int> insertUserText(UserText usertext) async {
    var dbClient = await db;
    return await dbClient.insert('Yazilar', usertext.toMap());
  }

  Future<void> deleteUserText(int id) async {
    var dbClient = await db;
    return await dbClient.delete('Yazilar', where: 'id=?', whereArgs: [id]);
  }

  Future<int> updateUserText(UserText usertext, int id) async {
    var dbClient = await db;
    return await dbClient
        .update('Yazilar', usertext.toMap(), where: 'id=?', whereArgs: [id]);
  }
}
