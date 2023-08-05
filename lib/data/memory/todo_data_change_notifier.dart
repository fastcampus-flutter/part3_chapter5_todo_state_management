import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/dart/collection/sort_functions.dart';
import 'package:fast_app_base/data/memory/vo_todo.dart';
import 'package:flutter/foundation.dart';

class TodoDataChangeNotifier extends ValueNotifier<List<Todo>> {
  TodoDataChangeNotifier() : super([]);

  Todo? get latestTodo => value.isEmpty
      ? null
      : value.sortedBy(byDateField<Todo>((element) => element.createdTime)).first;

  void addTodo(Todo todo) {
    value.add(todo);
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }

  void remove(Todo todo) {
    value.remove(todo);
    notifyListeners();
  }
}
