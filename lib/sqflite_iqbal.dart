import 'package:aplikasi_kontakapp_iqbal/model/kontak.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DbIqbal {
  static final DbIqbal _instance = DbIqbal._internal();
  static Database? _database;

  //inisialisasi beberapa variabel yang dibutuhkan
  final String tableName = 'tableKontak';
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnMobileNo = 'mobileNo';
  final String columnEmail = 'email';
  final String columnCompany = 'company';
  final String columnalamat = 'alamat';

  DbIqbal._internal();
  factory DbIqbal() => _instance;

  //cek database
  Future<Database?> get _db async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();
    return _database;
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'kontak.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  //membuat tabel beserta field-fieldnya
  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, "
        "$columnName TEXT,"
        "$columnMobileNo TEXT,"
        "$columnEmail TEXT,"
        "$columnCompany TEXT,"
        "$columnalamat TEXT)";
    await db.execute(sql);
  }

  //memasukkan ke database
  Future<int?> saveKontak(KontakApp kontak) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, kontak.toMap());
  }

  //membaca database
  Future<List?> getAllKontak() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName, columns: [
      columnId,
      columnName,
      columnCompany,
      columnMobileNo,
      columnEmail,
      columnalamat
    ]);

    return result.toList();
  }

  //memperbarui database
  Future<int?> updateKontak(KontakApp kontak) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, kontak.toMap(),
        where: '$columnId = ?', whereArgs: [kontak.id]);
  }

  //hapus database
  Future<int?> deleteKontak(int id) async {
    var dbClient = await _db;
    return await dbClient!
        .delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
