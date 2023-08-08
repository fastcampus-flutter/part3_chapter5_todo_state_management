import 'package:easy_localization/easy_localization.dart';
import 'package:fast_app_base/data/memory/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'common/data/preference/app_preferences.dart';
import 'data/memory/app_block/app_bloc_observer.dart';
import 'data/memory/app_block/app_event_transformer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await AppPreferences.init();

  Bloc.observer = AppBlocObserver();
  Bloc.transformer = appEventTransformer;

  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ko')],
      fallbackLocale: const Locale('en'),
      path: 'assets/translations',
      useOnlyLangCode: true,
      child: const App()));
}
