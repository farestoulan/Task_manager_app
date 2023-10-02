import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/core/network/local/cache_helper.dart';

import 'config/app/my_app.dart';
import 'core/bloc_observer/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();

  bool isDark = CacheHelper.getData(key: 'isDark') ?? false;
  runApp(MyApp(isDark));
}
