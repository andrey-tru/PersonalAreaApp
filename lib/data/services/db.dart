import 'dart:async';
import 'package:personal_area_app/data/todo_item.dart';
import 'package:sqflite/sqflite.dart';

abstract class DB {
  static Database? _db;

  static int get _version => 1;

  static Future<void> init() async {
    if (_db != null) {
      return;
    }

    try {
      String _path = await getDatabasesPath() + 'login';
      _db = await openDatabase(_path, version: _version, onCreate: onCreate);
    } catch (ex) {
      throw Exception(ex);
    }
  }

  static void onCreate(Database db, int version) async => await db
      .execute('CREATE TABLE login (login STRING, password STRING)');

  static Future<List<Map<String, dynamic>>> query(String table) async =>
      _db!.query(table);

  static Future<int> insert(String table, Model model) async =>
      await _db!.insert(table, model.toMap());

  static Future<int> delete(String table) async => await _db!.delete(table);
}
