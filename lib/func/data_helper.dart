import 'dart:async';

import 'package:sqflite/sqflite.dart' as sql;

class DataHelper {
  static final StreamController<List<Map<String, dynamic>>> dataStream = StreamController<List<Map<String, dynamic>>>.broadcast();
  static final StreamController<List<Map<String, dynamic>>> noteStream = StreamController<List<Map<String, dynamic>>>.broadcast();
  static final StreamController<List<Map<String, dynamic>>> sdataStream = StreamController<List<Map<String, dynamic>>>.broadcast();

  static Future onConfig(sql.Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
  }


  static void createTable(sql.Batch batch) {
    batch.execute("DROP TABLE IF EXISTS data");
    batch.execute("""CREATE TABLE data(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title TEXT,
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  static void createNotes(sql.Batch batch) {
    batch.execute("DROP TABLE IF EXISTS notes");
    batch.execute("""CREATE TABLE notes(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    dbid INTEGER,
    isi TEXT,
    type TEXT,
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (dbid) REFERENCES data(id) ON DELETE CASCADE
    )""");
  }


  static Future<sql.Database> db() async {
    return sql.openDatabase('xenotes.db', version: 2, onCreate: (sql.Database database, int version) async {
      var batch = database.batch();
      createTable(batch);
      createNotes(batch);
      await batch.commit();
    });
  }

  static Future<int> createData(String title) async {
    final db = await DataHelper.db();
    final data = {"title":title};
    final id = await db.insert('data', data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> createNote(int dbid, String isi, String type) async {
    final db = await DataHelper.db();
    final data = {"dbid": dbid, "isi":isi, "type": type};
    final id = await db.insert('notes', data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
    print(id);
    return id;
  }

  static Stream<List<Map<String, dynamic>>> getDataStream() {
    getData();
    return dataStream.stream;
  }

  static Future<void> getData() async {
    final db = await DataHelper.db();
    final ds = await db.query("data", orderBy: "id DESC");
    dataStream.add(ds);
  }

  static Stream<List<Map<String, dynamic>>> searchDataStream(String? title) {
    searchData(title);
    return sdataStream.stream;
  }

  static Future<void> searchData(String? title) async {
    final db = await DataHelper.db();
    final ds = await db.query("data", where: "title = ?", whereArgs: [title]);
    sdataStream.add(ds);
  }

  static Stream<List<Map<String, dynamic>>> getNoteStream(int m) {
    getNotes(m);
    return noteStream.stream;
  }

  static Future<void> getNotes(int dbid) async {
    final db = await DataHelper.db();
    final ds = await db.query("notes", where: "dbid = ?",whereArgs: [dbid], orderBy: "createdAt ASC" );
    noteStream.add(ds);
  }

  static Future<int> updateNotes(int id, String? isi) async{
    final db = await DataHelper.db();
    final data = {"isi":isi};
    final result = await db.update("notes", data, where: "id = ?", whereArgs: [id]);
    return result;
  }
  static Future<int> updateData(int id, String? title) async{
    final db = await DataHelper.db();
    final data = {"title":title};
    final result = await db.update("data", data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> delNotes(int id) async {
    final db = await DataHelper.db();
    await db.delete("notes", where: "id = ?", whereArgs: [id]);
  }

  static Future<void> delFNotes(int dbid) async {
    final db = await DataHelper.db();
    await db.delete("notes", where: "dbid = ?", whereArgs: [dbid]);
  }

  static Future<void> delData(int id) async {
    final db = await DataHelper.db();
    await db.delete("data", where: "id = ?", whereArgs: [id]);
  }
}