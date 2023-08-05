import 'package:fast_app_base/data/memory/todo_status.dart';

class Todo {
  Todo({
    required this.title,
    required this.dueDate,
  })  : createdTime = DateTime.now(),
        status = TodoStatus.incomplete;

  String title;
  String? content;
  final DateTime createdTime;
  DateTime? modifyTime;
  DateTime dueDate;
  TodoStatus status;
}
