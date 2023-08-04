import 'package:fast_app_base/data/memory/todo_data_change_notifier.dart';
import 'package:fast_app_base/data/memory/vo_todo.dart';
import 'package:flutter/material.dart';

class TodoDataHolder extends InheritedWidget {
  final TodoDataChangeNotifier todoDataChangeNotifier;

  const TodoDataHolder({
    required this.todoDataChangeNotifier,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(TodoDataHolder oldWidget) {
    return false;
  }

  void addTodo(Todo todo) {
    todoDataChangeNotifier.addTodo(todo);
  }

  static TodoDataHolder of(BuildContext context) {
    TodoDataHolder inherited = (context.dependOnInheritedWidgetOfExactType<TodoDataHolder>())!;
    return inherited;
  }
}
