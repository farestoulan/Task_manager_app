import '../../data/models/taskes_model/tasks_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchTextTaskNameChangedLoadingState extends SearchState {}

class SearchTextTaskNameChangedSuccessState extends SearchState {
  final List<TasksModel> searchedTasksList;

  SearchTextTaskNameChangedSuccessState({required this.searchedTasksList});
}

class GetTasksSearchedError extends SearchState {
  final String error;

  GetTasksSearchedError({required this.error});
}
