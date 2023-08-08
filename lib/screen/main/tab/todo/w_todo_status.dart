import 'package:fast_app_base/common/dart/extension/context_extension.dart';
import 'package:flutter/material.dart';

import '../../../../data/memory/vo_todo.dart';

class TodoStatusWidget extends StatelessWidget {
  final Todo todo;

  const TodoStatusWidget(this.todo, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 50,
        height: 50,
        child: Checkbox(
          value: true,
          onChanged: null,
          fillColor: MaterialStateProperty.all(
            context.appColors.checkBoxColor,
          ),
        ));
  }
}
