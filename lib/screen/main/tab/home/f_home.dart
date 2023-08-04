import 'package:fast_app_base/common/common.dart';
import 'package:flutter/material.dart';

import 'w_todo_list.dart';

class HomeFragment extends StatelessWidget {
  const HomeFragment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.appColors.seedColor.getSwatchByBrightness(100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => openDrawer(context),
                icon: const Icon(Icons.menu),
              )
            ],
          ),
          const EmptyExpanded(),
          Row(
            children: [
              const TodoList().pSymmetric(h: 20),
            ],
          ),
          const EmptyExpanded()
        ],
      ),
    );
  }

  void openDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }
}
