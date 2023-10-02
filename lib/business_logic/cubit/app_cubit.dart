import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/screens/add_categories_screen/add_categories_screen.dart';
import '../../presentation/screens/create_task_screen/create_task_screen.dart';
import '../../presentation/screens/tasks_history_screen/tasks_history_screen.dart';

part 'app_cubit_state.dart';

class AppCubit extends Cubit<AppCubitState> {
  AppCubit() : super(AppCubitInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  var currentIndex = 0;
  List<Widget> screens = [
    TasksHistoryScreen(),
    CreateTaskScreen(),
    AddCategoriesScreen()
  ];
  List<String> title = [
    'Tasks History',
    'Add New Task',
    'Categories',
  ];
  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }
}