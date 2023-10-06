import 'package:get_it/get_it.dart';
import 'package:task_manager_app/business_logic/categories_cubit/categories_cubit.dart';
import 'package:task_manager_app/business_logic/tasks_cubit/tasks_cubit.dart';
import 'package:task_manager_app/business_logic/tasks_history_cubit/tasks_history_cubit.dart';
import 'package:task_manager_app/data/repositories/categories_repository/categories_reposirory.dart';
import 'package:task_manager_app/data/repositories/tasks_history_repository/tasks_history_repository.dart';

import 'data/repositories/tasks_repository/tasks_repository.dart';

final sl = GetIt.instance;

Future<void> initInjector() async {
//============================ cubits==========================================

  sl.registerFactory(() => CategoriesCubit(categoriesRepository: sl()));

  sl.registerFactory(() => TasksCubit(tasksRepository: sl()));

  sl.registerFactory(() => TasksHistoryCubit(tasksHistoryRepository: sl()));

  //================================== Repository===============================

  sl.registerLazySingleton<CategoriesRepository>(() => CategoriesRepository());

  sl.registerLazySingleton<TasksRepository>(() => TasksRepository());

  sl.registerLazySingleton<TasksHistoryRepository>(
      () => TasksHistoryRepository());
}
