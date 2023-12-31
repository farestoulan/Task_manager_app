import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/network/local/cache_helper.dart';
import '../../presentation/screens/add_categories_screen/categories_manager_screen.dart';
import '../../presentation/screens/create_task_screen/create_task_screen.dart';
import '../../presentation/screens/tasks_history_screen/tasks_history_screen.dart';
import 'app_cubit_state.dart';

class AppCubit extends Cubit<AppCubitState> {
  AppCubit() : super(AppCubitInitial());

  static AppCubit get(context) => BlocProvider.of(context);
//=========================== Change Nav Bar Bottom ============================

  var currentIndex = 0;
  List<Widget> screens = [
    TasksHistoryScreen(),
    CreateTaskScreen(),
    AddCategoriesScreen()
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  bool isDark = false;
  void changeAppMode({bool? isDarkFromShared}) {
    emit(AppChangeModeLoadingState());
    if (isDarkFromShared != null) {
      isDark = isDarkFromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {});
      emit(AppChangeModeState());
    }
  }
}
