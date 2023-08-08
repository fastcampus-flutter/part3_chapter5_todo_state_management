import '../vo_todo.dart';

/// Event being processed by [TodoBloc].
abstract class TodoEvent {}

class TodoAddedEvent extends TodoEvent {}

class TodoStatusUpdateEvent extends TodoEvent {
  final Todo newTodo;

  TodoStatusUpdateEvent(this.newTodo);
}

class TodoContentUpdatedEvent extends TodoEvent {
  final Todo newTodo;

  TodoContentUpdatedEvent(this.newTodo);
}

class TodoRemovedEvent extends TodoEvent {
  final Todo removedTodo;

  TodoRemovedEvent(this.removedTodo);
}
