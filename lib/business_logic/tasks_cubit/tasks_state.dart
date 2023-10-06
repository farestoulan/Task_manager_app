import '../../data/models/categories_model/categories_model.dart';

class TasksState {}

class TasksInitial extends TasksState {}

//=================== Get Categories
class GetCategoriesLoading extends TasksState {}

class GetCategoriesSuccess extends TasksState {
  final List<CategoriesModel> categoriesList;

  GetCategoriesSuccess({required this.categoriesList});
}

class GetCategoriesError extends TasksState {
  final String error;

  GetCategoriesError({required this.error});
}

//==================== Get Category Key

class GetCategoryKeySuccess extends TasksState {
  final int key;

  GetCategoryKeySuccess({required this.key});
}

//=================== Add Categories
class AddTaskLoading extends TasksState {}

class AddTaskSuccess extends TasksState {}

class AddTaskError extends TasksState {
  final String error;

  AddTaskError({required this.error});
}

class DateAndTimePickedSuccess extends TasksState {}
