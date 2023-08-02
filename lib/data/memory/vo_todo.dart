class Todo {
  Todo({required this.title}) : createdTime = DateTime.now();

  String title;
  String? content;
  DateTime createdTime;
  DateTime? modifyTime;
  DateTime? dueDate;
}
