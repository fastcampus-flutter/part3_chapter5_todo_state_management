import 'package:fast_app_base/data/memory/block/todo_event.dart';
import 'package:fast_app_base/data/memory/todo_status.dart';
import 'package:fast_app_base/data/memory/vo_todo.dart';
import 'package:fast_app_base/screen/dialog/d_confirm.dart';
import 'package:fast_app_base/screen/main/write/d_write_todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoBloc extends  Bloc<TodoEvent, List<Todo>> {

  TodoBloc() : super([]) {
    on<TodoContentUpdated>((event, emit) => emit(state));
    on<TodoRemoved>((event, emit) => emit(state));
    on<TodoStatusUpdated>((event, emit) => emit(state));
  }
  int get newId {
    return DateTime.now().millisecondsSinceEpoch;
  }

  void addTodo(BuildContext context) async {
    final result = await WriteTodoBottomSheet().show();
    result?.runIfSuccess((data) {
      final newTodo = Todo(
        id: newId,
        title: data.title,
        dueDate: data.dueDate,
      );
      state.add(newTodo);
      emit(state);
    });
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
    emit(state);
  }

  editTodo(Todo todo) async {
    final result = await WriteTodoBottomSheet(todoForEdit: todo).show();
    result?.runIfSuccess((data) {
      todo.modifyTime = DateTime.now();
      todo.title = data.title;
      todo.dueDate = data.dueDate;
    });
    emit(state);
  }

  void removeTodo(Todo todo) {
    state.remove(todo);
  }
}