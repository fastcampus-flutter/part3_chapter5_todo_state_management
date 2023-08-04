import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/dart/extension/datetime_extension.dart';
import 'package:flutter/material.dart';

import '../../../../data/memory/vo_todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;

  const TodoItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.appColors.seedColor.getSwatchByBrightness(30),
      child: (Column(
        children: [
          todo.title.text.size(20).medium.make(),
          if (todo.dueDate != null) todo.dueDate!.formattedDate.text.size(10).medium.make(),
        ],
      )).p(30),
    );
  }
}
