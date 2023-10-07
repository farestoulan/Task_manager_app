import 'package:task_manager_app/data/models/categories_model/categories_model.dart';

import '../../data/models/taskes_model/tasks_model.dart';

class CategoriesState {}

class CategoriesInitial extends CategoriesState {}

//=================== Get Categories
class GetCategoriesLoading extends CategoriesState {}

class GetCategoriesSuccess extends CategoriesState {
  final List<CategoriesModel> categoriesList;

  GetCategoriesSuccess({required this.categoriesList});
}

class GetCategoriesError extends CategoriesState {
  final String error;

  GetCategoriesError({required this.error});
}

//=================== Add Categories
class AddCategoriesLoading extends CategoriesState {}

class AddCategoriesSuccess extends CategoriesState {}

class AddCategoriesError extends CategoriesState {
  final String error;

  AddCategoriesError({required this.error});
}

//=================== Delet Categories
class DeletCategoriesLoading extends CategoriesState {}

class DeletCategoriesSuccess extends CategoriesState {}

class DeletCategoriesError extends CategoriesState {
  final String error;

  DeletCategoriesError({required this.error});
}

//=================== Edit Categories
class EditCategoriesLoading extends CategoriesState {}

class EditCategoriesSuccess extends CategoriesState {}

class EditCategoriesError extends CategoriesState {
  final String error;

  EditCategoriesError({required this.error});
}

//=================== Get Task
class GetTaksLoading extends CategoriesState {}

class GetTasksSuccess extends CategoriesState {
  final List<TasksModel> tasksList;

  GetTasksSuccess({required this.tasksList});
}

class GetTasksError extends CategoriesState {
  final String error;

  GetTasksError({required this.error});
}

//=========================== delet category

class DeletCategorySuccess extends CategoriesState {
  final int categoryKey;
  final CategoriesModel categoriesModel;

  DeletCategorySuccess(
      {required this.categoryKey, required this.categoriesModel});
}
