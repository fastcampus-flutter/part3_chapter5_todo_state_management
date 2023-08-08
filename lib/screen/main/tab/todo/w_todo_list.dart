import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/screen/main/tab/todo/w_todo_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/memory/block/todo_bloc_state.dart';
import '../../../../data/memory/todo_bloc.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    final todoBloc = context.readTodoBloc;
    return BlocBuilder<TodoBloc, TodoBlocState>(
      builder: (context, data) => todoBloc.state.todoList.isEmpty
          ? '할일을 작성해보세요'.text.size(30).makeCentered()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: todoBloc.state.todoList
                    .map((e) => TodoItem(
                          todo: e,
                        ))
                    .toList(),
              ),
            ),
    );
  }
}
