import 'package:fast_app_base/data/memory/block/todo_event.dart';
import 'package:fast_app_base/data/memory/todo_status.dart';
import 'package:fast_app_base/data/memory/vo_todo.dart';
import 'package:fast_app_base/screen/dialog/d_confirm.dart';
import 'package:fast_app_base/screen/main/write/d_write_todo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'block/block_status.dart';
import 'block/todo_bloc_state.dart';

class TodoBloc extends  Bloc<TodoEvent, TodoBlocState> {
  final List<Todo> todoList = [];

  TodoBloc() : super(TodoBlocState(Status.initial, [])) {
    on<TodoContentUpdatedEvent>(_editTodo);
    on<TodoRemovedEvent>(_removeTodo);
    on<TodoStatusUpdateEvent>(_changeTodoStatus);
    on<TodoAddedEvent>(_addTodo);
  }
  int get newId {
    return DateTime.now().millisecondsSinceEpoch;
  }

  void _addTodo(TodoEvent event, Emitter<TodoBlocState> emitter) async {
    final result = await WriteTodoBottomSheet().show();
    result?.runIfSuccess((data) {
      final newTodo = Todo(
        id: newId,
        title: data.title,
        dueDate: data.dueDate,
      );
      state.todoList.add(newTodo);
      emitter(state);
    });
  }

  void _changeTodoStatus(TodoStatusUpdateEvent event, Emitter<TodoBlocState> emitter) async {
    final todo = event.newTodo;
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
    emitter(state);
  }

  void _editTodo(TodoContentUpdatedEvent event, Emitter<TodoBlocState> emitter) async {
    final todo = event.newTodo;
    final result = await WriteTodoBottomSheet(todoForEdit: todo).show();
    result?.runIfSuccess((data) {
      todo.modifyTime = DateTime.now();
      todo.title = data.title;
      todo.dueDate = data.dueDate;
    });
    emitter(state);
  }

  void _removeTodo(TodoRemovedEvent event, Emitter<TodoBlocState> emitter){
    state.todoList.remove(event.removedTodo);
  }
}