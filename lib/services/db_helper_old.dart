import 'package:ezberci/models/user/text/text.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
      return _db;
    } else {
      return _db;
    }
  }

  Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(), "typer.db");
    var typerDb = await openDatabase(dbPath, version: 1, onCreate: createDb);
    return typerDb;
  }

  void createDb(Database db, int version) async {
    await db.execute(
        "create table yazilar(textId integer primary key, baslik text, metin text)");
  }

  Future<List<UserText>> getTexts() async {
    Database db = await this.db;
    var result = await db.query("yazilar");
    print(result);
    return List.generate(result.length, (i) {
      return UserText.fromObject(result[i]);
    });
  }

  Future<int> insert(UserText text) async {
    Database db = await this.db;
    print(text.toMap());

    var result = await db.insert("yazilar", text.toMap());
    return result;
  }

  Future<int> delete(int textId) async {
    Database db = await this.db;

    var result = db.rawDelete("delete from yazilar where textId= $textId");
    return result;
  }

  Future<int> update(UserText text) async {
    Database db = await this.db;

    var result = await db.update("yazilar", text.toMap(),
        where: "textId=?", whereArgs: [text.id]);
    return result;
  }
}
