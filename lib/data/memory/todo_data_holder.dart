import 'package:fast_app_base/data/memory/todo_data_change_notifier.dart';
import 'package:fast_app_base/data/memory/todo_status.dart';
import 'package:fast_app_base/data/memory/vo_todo.dart';
import 'package:fast_app_base/screen/dialog/d_confirm.dart';
import 'package:fast_app_base/screen/main/write/d_write_todo.dart';
import 'package:flutter/material.dart';

class TodoDataHolder extends InheritedWidget {
  final TodoDataChangeNotifier todoDataChangeNotifier;
  //static BuildContext? _tempContext;

  const TodoDataHolder({
    required this.todoDataChangeNotifier,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  int get newId {
    return DateTime.now().millisecondsSinceEpoch;
  }

  @override
  bool updateShouldNotify(TodoDataHolder oldWidget) {
    return false;
  }

  void addTodo(BuildContext context) async {
    final result = await WriteTodoBottomSheet().show();
    result?.runIfSuccess((data) {
      final newTodo = Todo(
        id: context.todoDataHolder.newId,
        title: data.title,
        dueDate: data.dueDate,
      );
      todoDataChangeNotifier.addTodo(newTodo);
    });
  }

  // void addTodoWithoutContext() async {
  //   final result = await WriteTodoBottomSheet().show();
  //   result?.runIfSuccess((data) {
  //     final newTodo = Todo(
  //       id: TodoDataHolder._tempContext!.todoDataHolder.newId,
  //       title: data.title,
  //       dueDate: data.dueDate,
  //     );
  //     todoDataChangeNotifier.addTodo(newTodo);
  //   });
  // }

  static TodoDataHolder _of(BuildContext context) {
    //TodoDataHolder._tempContext = context;
    TodoDataHolder inherited = (context.dependOnInheritedWidgetOfExactType<TodoDataHolder>())!;
    return inherited;
  }

  void changeTodoStatus(Todo todo) async {
    switch (todo.status) {
      case TodoStatus.complete:
        final result = await ConfirmDialog('다시 처음 상태로 변경하시겠어요?').show();
        result?.runIfSuccess((data) {
          todo.status = TodoStatus.incomplete;
        });
      case TodoStatus.incomplete:
        todo.status = TodoStatus.ongoing;
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

  void removeTodo(Todo todo) {
    todoDataChangeNotifier.remove(todo);
  }
}

extension TodoContextExtension on BuildContext {
  TodoDataHolder get todoDataHolder => TodoDataHolder._of(this);
}
