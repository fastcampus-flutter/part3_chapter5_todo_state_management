import 'package:flutter/cupertino.dart';

import 'vo_todo.dart';

class TodoDataNotifier extends ValueNotifier<List<Todo>> {
  TodoDataNotifier() : super([]);

  void addTodo(Todo todo){
    value.add(todo);
    notifyListeners();
  }

  void notify(){
    notifyListeners();
  }
}
