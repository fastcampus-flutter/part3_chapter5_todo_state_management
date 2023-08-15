import 'package:fast_app_base/data/memory/todo_status.dart';
import 'package:fast_app_base/data/memory/vo_todo.dart';
import 'package:fast_app_base/screen/dialog/d_confirm.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../screen/main/write/d_write_todo.dart';

final userProvider = FutureProvider<String>((ref) => 'abc');

final todoDataProvider = StateNotifierProvider<TodoDataHolder, List<Todo>>((ref) {
  final userID = ref.watch(userProvider);
  debugPrint(userID.value!);
  return TodoDataHolder();
});

class TodoDataHolder extends StateNotifier<List<Todo>> {
  TodoDataHolder() : super([]);

  void changeTodoStatus(Todo todo) async {
    switch (todo.status) {
      case TodoStatus.incomplete:
        todo.status = TodoStatus.ongoing;
      case TodoStatus.ongoing:
        todo.status = TodoStatus.complete;
      case TodoStatus.complete:
        final result = await ConfirmDialog('정말로 처음 상태로 변경하시겠어요?').show();
        result?.runIfSuccess((data) {
          todo.status = TodoStatus.incomplete;
        });
    }
    state = List.of(state);
  }

  void addTodo() async {
    final result = await WriteTodoDialog().show();
    if (result != null) {
      state.add(Todo(
        id: DateTime.now().millisecondsSinceEpoch,
        title: result.text,
        dueDate: result.dateTime,
      ));
      state = List.of(state);
    }
  }

  void editTodo(Todo todo) async {
    final result = await WriteTodoDialog(todoForEdit: todo).show();
    if (result != null) {
      todo.title = result.text;
      todo.dueDate = result.dateTime;
      state = List.of(state);
    }
  }

  void removeTodo(Todo todo) {
    state.remove(todo);
    state = List.of(state);
  }
}

extension TodoListHolderProvider on WidgetRef {
  TodoDataHolder get readTodoHolder => read(todoDataProvider.notifier);
}
