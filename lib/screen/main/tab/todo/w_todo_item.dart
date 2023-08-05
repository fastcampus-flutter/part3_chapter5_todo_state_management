import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/dart/extension/datetime_extension.dart';
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
            ],
          ),
        ],
      ).p(20),
    );
  }
}
