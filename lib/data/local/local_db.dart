import 'package:fast_app_base/data/local/collection/todo_db_model.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/local/error/local_db_error.dart';
import '../simple_result.dart';

class LocalDB {
  static late final Isar _isar;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([TodoDbModelSchema], maxSizeMiB: 512, directory: dir.path);
  }

  static Future<SimpleResult<List<TodoDbModel>, String>> getTodoList() async {
    try {
      debugPrint('get response success');
      final documents = await _isar.todoDbModels.filter().idGreaterThan(0).findAll();
      return SimpleResult.success(documents);
    } catch (e) {
      debugPrint('get response fail');
      return SimpleResult.failure(e.toString());
    }
  }

  static Future<SimpleResult<void, LocalDBError>> addTodo(TodoDbModel model) async {
    await _isar.writeTxn(() async {
      await _isar.todoDbModels.put(model);
    });
    return SimpleResult.success();
  }

  static Future<SimpleResult<void, LocalDBError>> updateTodo(TodoDbModel model) async {
    await _isar.writeTxn(() async {
      await _isar.todoDbModels.put(model);
    });
    return SimpleResult.success();
  }

  static Future<SimpleResult<void, LocalDBError>> removeTodo(Id id) async {
    await _isar.writeTxn(() async {
      await _isar.todoDbModels.delete(id);
    });
    return SimpleResult.success();
  }
}
