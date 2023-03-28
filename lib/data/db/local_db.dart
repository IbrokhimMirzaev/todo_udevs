import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_udevs/data/models/cached_model.dart';

class LocalDb {
  static final LocalDb getInstance = LocalDb._init();
  LocalDb._init();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB("todos.db");
      return _database!;
    }
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final String totalPath = join(dbPath, fileName);
    return await openDatabase(totalPath, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const intType = "INTEGER NOT NULL";

    await db.execute('''
    CREATE TABLE ${CachedFields.tableName} (
    ${CachedFields.id} $idType,
    ${CachedFields.categoryId} $intType,
    ${CachedFields.title} $textType,
    ${CachedFields.dateTime} $textType,
    ${CachedFields.isDone} $intType,
    ${CachedFields.isBell} $intType
    )
    ''');
  }
}