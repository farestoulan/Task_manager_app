import 'package:task_manager_app/data/models/taskes_model/tasks_model.dart';

import '../../data/models/categories_model/categories_model.dart';

class TasksHistoryState {}

class TasksHistoryInitial extends TasksHistoryState {}

//=================== Get Task
class GetTaksLoading extends TasksHistoryState {}

class GetTasksSuccess extends TasksHistoryState {
  final List<TasksModel> tasksList;

  GetTasksSuccess({required this.tasksList});
}

class GetTasksError extends TasksHistoryState {
  final String error;

  GetTasksError({required this.error});
}

//=================== Delet Task
class DeletTaskLoading extends TasksHistoryState {}

class DeletTaskSuccess extends TasksHistoryState {}

class DeletTaskError extends TasksHistoryState {
  final String error;

  DeletTaskError({required this.error});
}

//=================== Get Categories
class GetCategoryValueLoading extends TasksHistoryState {}

class GetCategoryValueSuccess extends TasksHistoryState {
  final String categoryValue;

  GetCategoryValueSuccess({required this.categoryValue});
}

class GetCategoryValueError extends TasksHistoryState {
  final String error;

  GetCategoryValueError({required this.error});
}

//=========================== edit Task Action
class EditTaskActionSuccess extends TasksHistoryState {}

//=================== Edit Task Save
class EditTaskLoading extends TasksHistoryState {}

class EditTaskSuccess extends TasksHistoryState {}

class EditTaskError extends TasksHistoryState {
  final String error;

  EditTaskError({required this.error});
}

//===========================
class GetCategoryNameLoading extends TasksHistoryState {}

class GetCategorySuccessName extends TasksHistoryState {
  final String categoryName;

  GetCategorySuccessName({required this.categoryName});
}

class GetCategoryErrorName extends TasksHistoryState {
  final String error;

  GetCategoryErrorName({required this.error});
}

//=================== Get Categories
class GetCategoriesLoading extends TasksHistoryState {}

class GetCategoriesSuccess extends TasksHistoryState {
  final List<CategoriesModel> categoriesList;

  GetCategoriesSuccess({required this.categoriesList});
}

class GetCategoriesError extends TasksHistoryState {
  final String error;

  GetCategoriesError({required this.error});
}
//==================== Get Category Key

class GetCategoryKeySuccess extends TasksHistoryState {
  final int key;

  GetCategoryKeySuccess({required this.key});
}

//===================== Filter By deu Date
class FilterByDeuDateSuccess extends TasksHistoryState {}
