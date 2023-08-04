import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/data/memory/todo_data_holder.dart';
import 'package:fast_app_base/screen/main/tab/home/w_todo_item.dart';
import 'package:flutter/material.dart';

import '../../../../data/memory/vo_todo.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: TodoDataHolder.of(context).todoDataChangeNotifier,
      builder: (BuildContext context, List<Todo> todoList, Widget? child) {
        return todoList.isEmpty
            ? '노트를 작성해보세요'.text.make()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: todoList
                    .map((e) => TodoItem(
                          todo: e,
                        ))
                    .toList(),
              );
      },
    );
  }
}
