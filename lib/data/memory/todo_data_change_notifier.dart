import 'package:fast_app_base/data/memory/vo_todo.dart';
import 'package:flutter/foundation.dart';

class TodoDataChangeNotifier extends ValueNotifier<List<Todo>> {
  TodoDataChangeNotifier() : super([]);

  void addTodo(Todo todo) {
    value.add(todo);
    notifyListeners();
  }
}
