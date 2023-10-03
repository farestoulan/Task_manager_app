import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:task_manager_app/core/network/local/cache_helper.dart';
import 'config/app/my_app.dart';
import 'core/bloc_observer/bloc_observer.dart';
import 'data/models/categories_model/categories_model.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  await Hive.initFlutter();
  di.initInjector();

  Hive.registerAdapter(CategoriesModelAdapter());
  await Hive.openBox<CategoriesModel>('Categories');

  bool isDark = CacheHelper.getData(key: 'isDark') ?? false;

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp(isDark));
}
