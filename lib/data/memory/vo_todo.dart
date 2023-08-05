import 'package:fast_app_base/data/memory/todo_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../local/collection/todo_db_model.dart';

part 'vo_todo.g.dart';

@JsonSerializable()
class Todo {
  Todo({
    required this.id,
    required this.title,
    required this.dueDate,
    this.modifyTime,
    TodoStatus? status,
    DateTime? createdTime,
  })  : createdTime = createdTime ?? DateTime.now(),
        status = status ?? TodoStatus.incomplete;

  int id;
  String title;
  final DateTime createdTime;
  DateTime? modifyTime;
  DateTime dueDate;
  TodoStatus status;

  factory Todo.fromJson(Map<String, Object?> json) => _$TodoFromJson(json);

  factory Todo.fromDB(TodoDbModel e) {
    return Todo(
        id: e.id,
        title: e.title,
        dueDate: e.dueDate,
        createdTime: e.createdTime,
        status: e.status,
        modifyTime: e.modifyTime);
  }

  TodoDbModel get dbModel => TodoDbModel(id, createdTime, modifyTime, title, dueDate, status);

  Map<String, dynamic> toJson() => _$TodoToJson(this);
}
