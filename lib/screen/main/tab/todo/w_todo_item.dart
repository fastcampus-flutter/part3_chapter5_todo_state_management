import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/dart/extension/datetime_extension.dart';
import 'package:fast_app_base/data/memory/todo_data_holder.dart';
import 'package:fast_app_base/screen/main/tab/todo/w_todo_status.dart';
import 'package:flutter/material.dart';

import '../../../../common/widget/w_rounded_container.dart';
import '../../../../data/memory/vo_todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;

  const TodoItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      margin: const EdgeInsets.symmetric(vertical: 3),
      color: context.appColors.itemBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          todo.dueDate.relativeDays.text.size(10).medium.make(),
          Row(
            children: [
              TodoStatusWidget(todo),
              Expanded(child: todo.title.text.size(20).medium.make()),
              IconButton(
                  onPressed: () => context.todoDataHolder.editTodo(todo),
                  icon: const Icon(EvaIcons.editOutline))
            ],
          ),
        ],
      ).pOnly(top: 15, right: 15, bottom: 10, left: 5),
    );
  }
}
