/// Event being processed by [TodoBloc].
abstract class TodoEvent {}

class TodoStatusUpdated extends TodoEvent {}
class TodoContentUpdated extends TodoEvent {}
class TodoRemoved extends TodoEvent {}