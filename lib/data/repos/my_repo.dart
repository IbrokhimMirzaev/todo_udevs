import 'package:todo_udevs/data/db/local_db.dart';
import 'package:todo_udevs/data/models/cached_model.dart';

class MyTodoRepo {
  Future<List<CachedModel>> getAllToDos() async {
    final db = await LocalDb.getInstance.database;
    const orderBy = "${CachedFields.dateTime} ASC";
    final toDos = await db.query(CachedFields.tableName, orderBy: orderBy);
    return toDos.map((json) => CachedModel.fromJson(json)).toList();
  }

  Future<CachedModel> addCacheToDo(CachedModel cachedTodo) async {
    final db = await LocalDb.getInstance.database;
    final id = await db.insert(CachedFields.tableName, cachedTodo.toJson());
    return cachedTodo.copyWith(id: id);
  }

  Future<int> deleteCachedTodoById(int id) async {
    final db = await LocalDb.getInstance.database;
    var t = await db.delete(CachedFields.tableName, where: "${CachedFields.id}=?", whereArgs: [id]);
    if (t > 0) {
      return t;
    } else {
      return -1;
    }
  }

  Future<void> updateCachedTodo({
    required CachedModel cachedTodo,
  }) async {
    var toDo = cachedTodo.toJson();
    print("ID: ${cachedTodo.id}");

    final db = await LocalDb.getInstance.database;
    await db.update(
      CachedFields.tableName,
      {
        CachedFields.isDone: toDo[CachedFields.isDone],
        CachedFields.title: toDo[CachedFields.title],
        CachedFields.categoryId: toDo[CachedFields.categoryId],
        CachedFields.dateTime: toDo[CachedFields.dateTime],
      },
      where: '${CachedFields.id} = ?',
      whereArgs: [cachedTodo.id],
    );
  }

  Future<void> changeDoneToTrue({required CachedModel cachedTodo}) async {
    final db = await LocalDb.getInstance.database;

    await db.update(
      CachedFields.tableName,
      {
        CachedFields.isDone: 1,
      },
      where: '${CachedFields.id} = ?',
      whereArgs: [cachedTodo.id],
    );
  }

  Future<void> changeDoneToFalse({required CachedModel cachedTodo}) async {
    final db = await LocalDb.getInstance.database;

    await db.update(
      CachedFields.tableName,
      {
        CachedFields.isDone: 0,
      },
      where: '${CachedFields.id} = ?',
      whereArgs: [cachedTodo.id],
    );
  }
}
