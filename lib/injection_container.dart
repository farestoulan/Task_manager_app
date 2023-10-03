import 'package:get_it/get_it.dart';
import 'package:task_manager_app/business_logic/categories_cubit/categories_cubit.dart';
import 'package:task_manager_app/data/repositories/categories_repository/categories_reposirory.dart';

final sl = GetIt.instance;

Future<void> initInjector() async {
//============================ cubits==========================================

  sl.registerFactory(() => CategoriesCubit(categoriesRepository: sl()));

  //================================== Repository===============================

  sl.registerLazySingleton<CategoriesRepository>(() => CategoriesRepository());
}
