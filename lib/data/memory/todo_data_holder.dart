import 'package:fast_app_base/data/memory/todo_data_change_notifier.dart';
import 'package:fast_app_base/data/memory/todo_status.dart';
import 'package:fast_app_base/data/memory/vo_todo.dart';
import 'package:fast_app_base/screen/dialog/d_confirm.dart';
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

  void changeTodoStatus(Todo todo) async {
    switch (todo.status) {
      case TodoStatus.complete:
        final result = await ConfirmDialog('다시 처음 상태로 변경하시겠어요?').show();
        result?.runIfSuccess((data) {
          todo.status = TodoStatus.incomplete;
          //todoDataChangeNotifier.notifyListeners();
        });
        break;
      case TodoStatus.incomplete:
        todo.status = TodoStatus.ongoing;
      //todoDataChangeNotifier.notifyListeners();
      case TodoStatus.ongoing:
        todo.status = TodoStatus.complete;
    }
    todoDataChangeNotifier.notifyListeners();
  }
}
