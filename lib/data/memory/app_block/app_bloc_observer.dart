import 'package:fast_app_base/data/memory/block/todo_event.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver implements BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    debugPrint('onChange');
  }

  @override
  void onClose(BlocBase bloc) {
    debugPrint('onClose');
  }

  @override
  void onCreate(BlocBase bloc) {
    debugPrint('onCreate');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('onError');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    if (event is TodoEvent) {
      switch (event) {
        case TodoRemovedEvent():
          debugPrint('removed Event');
        case TodoContentUpdatedEvent():
          debugPrint('content Updated Event');
        case TodoStatusUpdateEvent():
          debugPrint('status Updated Event');
        case TodoAddedEvent():
          debugPrint('added Event');
      }
    } else {
      debugPrint('onEvent Others');
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    debugPrint('onTransition');
  }
}
