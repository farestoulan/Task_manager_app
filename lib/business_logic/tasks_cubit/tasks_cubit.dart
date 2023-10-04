import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/business_logic/tasks_cubit/tasks_state.dart';
import 'package:task_manager_app/data/repositories/tasks_repository/tasks_repository.dart';

import '../../data/models/categories_model/categories_model.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit({required this.tasksRepository}) : super(TasksInitial());
  final TasksRepository tasksRepository;

  static TasksCubit get(context) => BlocProvider.of(context);

  //=============================== get categories
  void getCategories() {
    try {
      emit(GetCategoriesLoading());
      tasksRepository.getCategories().then((categoriesList) {
        emit(GetCategoriesSuccess(categoriesList: categoriesList));
      }).catchError((error) {
        emit(GetCategoriesError(error: error.toString()));
      });
    } catch (e) {
      emit(GetCategoriesError(error: e.toString()));
    }
  }

//============================ Get Category Key
  void getCategoryKey({
    required List<CategoriesModel> categoriesList,
    required String categoryNameSelected,
  }) {
    int key = 0;
    for (var index = 0; index <= categoriesList.length - 1; index++) {
      var element = categoriesList[index];
      if (element.categoryName == categoryNameSelected) {
        key = element.key;
        print('key : ***********$key');
        break;
      }
    }
    emit(GetCategoryKeySuccess(key: key));
  }
//=============================== Add Tasks

  void addTask({
    required String taskTitle,
    required String dueDate,
    required bool isCompleted,
    required int categoryId,
    required bool remindMe,
    required String reminderDate,
    required String reminderTime,
  }) {
    try {
      emit(AddTaskLoading());
      tasksRepository
          .addTasks(
        taskTitle: taskTitle,
        dueDate: dueDate,
        isCompleted: isCompleted,
        categoryId: categoryId,
        remindMe: remindMe,
        reminderDate: reminderDate,
        reminderTime: reminderTime,
      )
          .then((categoriesList) {
        emit(AddTaskSuccess());
      }).catchError((error) {
        emit(AddTaskError(error: error.toString()));
      });
    } catch (e) {
      emit(AddTaskError(error: e.toString()));
    }
  }
}
