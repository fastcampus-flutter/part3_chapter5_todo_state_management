import 'package:fast_app_base/data/memory/todo_data_change_notifier.dart';
import 'package:fast_app_base/data/memory/todo_status.dart';
import 'package:fast_app_base/data/memory/vo_todo.dart';
import 'package:fast_app_base/screen/dialog/d_confirm.dart';
import 'package:fast_app_base/screen/main/write/d_write_todo.dart';
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

  void addTodo() async {
    final result = await WriteTodoBottomSheet().show();
    result?.runIfSuccess((data) {
      todoDataChangeNotifier.addTodo(data);
    });
  }

  static TodoDataHolder _of(BuildContext context) {
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
    todoDataChangeNotifier.notify();
  }

  editTodo(Todo todo) async {
    final result = await WriteTodoBottomSheet(todoForEdit: todo).show();
    result?.runIfSuccess((data) {
      todo.modifyTime = DateTime.now();
      todo.title = data.title;
      todo.dueDate = data.dueDate;
      todoDataChangeNotifier.notify();
    });
  }
}

extension TodoContextExtension on BuildContext {
  TodoDataHolder get todoDataHolder => TodoDataHolder._of(this);
}
