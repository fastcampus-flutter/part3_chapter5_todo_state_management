import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/dart/extension/datetime_extension.dart';
import 'package:fast_app_base/common/hooks/use_focused.dart';
import 'package:fast_app_base/common/widget/scaffold/bottom_dialog_scaffold.dart';
import 'package:fast_app_base/common/widget/w_round_button.dart';
import 'package:fast_app_base/screen/main/write/vo_write_to_result.dart';
import 'package:flutter/material.dart';
import 'package:nav_hooks/dialog/hook_consumer_dialog.dart';
import 'package:nav_hooks/dialog/hook_dialog.dart';

import '../../../common/hooks/use_second_timer.dart';
import '../../../common/hooks/use_show_keyboard.dart';
import '../../../common/widget/w_rounded_container.dart';
import '../../../data/memory/vo_todo.dart';

class WriteTodoDialog extends HookConsumerDialogWidget<WriteTodoResult> {
  final Todo? todoForEdit;

  WriteTodoDialog({this.todoForEdit, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = useState<DateTime>(DateTime.now());
    final textController = useTextEditingController();
    final textController2 = useTextEditingController();

    if (todoForEdit != null) {
      useMemoized(() {
        selectedDate.value = todoForEdit!.dueDate;
        textController.text = todoForEdit!.title;
      });
    }

    final node = useFocusNode();
    final node2 = useFocusNode();

    showKeyboard(node);

    final isOneFocused = useIsFocused(node);
    final isTwoFocused = useIsFocused(node2);


    final secondTime = useTimerSecond();

    final tenTimesCount = useMemoized(() {
      print('tenTimesCount');
      print(secondTime);
      print(secondTime ~/ 10);
      return secondTime ~/ 10;
    }, [secondTime]);

    final twentyTimesCount =useMemoized(() {
      print('twentyTimesCount');
      print(tenTimesCount ~/ 2);
      return tenTimesCount ~/ 2;
    }, [tenTimesCount]);

    final wow = useCallback(() async {
      final date = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime.now().subtract(const Duration(days: 365)),
        lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
      );
      if (date != null) {
        selectedDate.value = date;
      }
    });

    return BottomDialogScaffold(
      body: RoundedContainer(
          padding: const EdgeInsets.all(20),
          color: isOneFocused
              ? AppColors.faleBlue
              : isTwoFocused
                  ? AppColors.salmon
                  : AppColors.grey,
          child: Column(
            children: [
              Row(
                children: [
                  '할일을 작성해주세요. $twentyTimesCount'.text.size(18).bold.make(),
                  spacer,
                  selectedDate.value.formattedDate.text.make(),
                  IconButton(onPressed: wow, icon: const Icon(Icons.calendar_month))
                ],
              ),
              height20,
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    focusNode: node,
                    controller: textController,
                  )),
                  RoundButton(
                      text: isEditMode ? '완료' : '추가',
                      onTap: () {
                        hide(WriteTodoResult(selectedDate.value, textController.text));
                      }),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    focusNode: node2,
                    controller: textController2,
                  )),
                  RoundButton(
                      text: isEditMode ? '완료' : '추가',
                      onTap: () {
                        hide(WriteTodoResult(selectedDate.value, textController.text));
                      }),
                ],
              )
            ],
          )),
    );
  }

  bool get isEditMode => todoForEdit != null;
}
