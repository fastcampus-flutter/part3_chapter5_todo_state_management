import 'package:fast_app_base/data/memory/vo_todo.dart';

import 'block_status.dart';

class TodoBlocState {
  TodoBlocState(this.status, this.todoList);

  Status status;
  final List<Todo> todoList;
}
