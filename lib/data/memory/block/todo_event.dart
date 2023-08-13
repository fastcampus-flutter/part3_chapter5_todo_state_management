import '../vo_todo.dart';

/// Event being processed by [TodoBloc].
sealed class TodoEvent {}

class TodoAddedEvent extends TodoEvent {}

class TodoStatusUpdateEvent extends TodoEvent {
  final Todo updatedTodo;

  TodoStatusUpdateEvent(this.updatedTodo);
}

class TodoContentUpdatedEvent extends TodoEvent {
  final Todo updatedTodo;

  TodoContentUpdatedEvent(this.updatedTodo);
}

class TodoRemovedEvent extends TodoEvent {
  final Todo removedTodo;

  TodoRemovedEvent(this.removedTodo);
}
