import 'package:fast_app_base/data/memory/todo_status.dart';
import 'package:fast_app_base/data/memory/vo_todo.dart';
import 'package:fast_app_base/screen/dialog/d_confirm.dart';
import 'package:fast_app_base/screen/main/write/d_write_todo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'block/block_status.dart';
import 'block/todo_bloc_state.dart';

class TodoCubit extends Cubit<TodoBlocState> {
  final List<Todo> todoList = [];

  TodoCubit() : super(const TodoBlocState(Status.initial, []));

  int get newId {
    return DateTime.now().millisecondsSinceEpoch;
  }

  void addTodo() async {
    final result = await WriteTodoBottomSheet().show();
    result?.runIfSuccess((data) {
      final newTodo = Todo(
        id: newId,
        title: data.title,
        dueDate: data.dueDate,
        createdTime: DateTime.now(),
        status: TodoStatus.incomplete,
      );
      final oldList = List<Todo>.from(state.todoList);
      oldList.add(newTodo);
      emit(state.copyWith(todoList: oldList));
    });
  }

  void changeTodoStatus(Todo todo) async {
    final eventTodo = todo;
    TodoStatus newStatus = eventTodo.status;
    switch (eventTodo.status) {
      case TodoStatus.complete:
        final result = await ConfirmDialog('다시 처음 상태로 변경하시겠어요?').show();
        result?.runIfSuccess((data) {
          newStatus = TodoStatus.incomplete;
        });
      case TodoStatus.incomplete:
        newStatus = TodoStatus.ongoing;
      case TodoStatus.ongoing:
        newStatus = TodoStatus.complete;
    }
    final oldCopiedList = List<Todo>.from(state.todoList);
    oldCopiedList[oldCopiedList.indexOf(eventTodo)] = eventTodo.copyWith(status: newStatus);
    emit(state.copyWith(todoList: oldCopiedList));
  }

  void editTodo(Todo todoForEdit) async {
    final result = await WriteTodoBottomSheet(todoForEdit: todoForEdit).show();
    result?.runIfSuccess((data) {
      final newTodo = todoForEdit.copyWith(
        modifyTime: DateTime.now(),
        title: data.title,
        dueDate: data.dueDate,
      );
      final oldCopiedList = List<Todo>.from(state.todoList);
      oldCopiedList[oldCopiedList.indexOf(todoForEdit)] = newTodo;
      emit(state.copyWith(todoList: oldCopiedList));
    });
  }

  void removeTodo(int todoId) {
    final copiedOldList = List<Todo>.from(state.todoList);
    copiedOldList.removeWhere((element) => todoId == element.id);
    emit(state.copyWith(todoList: copiedOldList));
  }
}
