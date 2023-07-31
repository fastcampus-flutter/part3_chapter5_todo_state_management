import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/data/simple_result.dart';
import 'package:flutter/material.dart';
import 'package:nav/dialog/dialog.dart';
import 'package:nav/enum/enum_nav_ani.dart';

class WriteTodoBottomSheet extends DialogWidget<SimpleResult> {
  WriteTodoBottomSheet({
    super.context,
    super.key,
    super.barrierColor = const Color(0x80000000),
    super.animation = NavAni.Bottom,
    super.useRootNavigator = false,
  });

  @override
  State<StatefulWidget> createState() => _WriteTodoBottomSheetState();
}

class _WriteTodoBottomSheetState extends DialogState<WriteTodoBottomSheet> {
  final todoTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              '할일을 작성해주세요.'.text.make(),
              TextField(
                controller: todoTextEditingController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
