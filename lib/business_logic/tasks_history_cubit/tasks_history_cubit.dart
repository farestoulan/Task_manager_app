import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/business_logic/tasks_history_cubit/tasks_history_state.dart';
import '../../core/network/local/cache_helper.dart';
import '../../data/models/categories_model/categories_model.dart';
import '../../data/models/taskes_model/tasks_model.dart';
import '../../data/repositories/tasks_history_repository/tasks_history_repository.dart';
import '../../presentation/screens/add_categories_screen/categories_manager_screen.dart';
import '../../presentation/screens/create_task_screen/create_task_screen.dart';
import '../../presentation/screens/tasks_history_screen/tasks_history_screen.dart';

class TasksHistoryCubit extends Cubit<TasksHistoryState> {
  final TasksHistoryRepository tasksHistoryRepository;
  TasksHistoryCubit({required this.tasksHistoryRepository})
      : super(TasksHistoryInitial());

  static TasksHistoryCubit get(context) => BlocProvider.of(context);
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

  //=============================== get Tasks
  void getTasks() {
    try {
      emit(GetTaksLoading());
      tasksHistoryRepository.getTasks().then((tasksList) {
        emit(GetTasksSuccess(tasksList: tasksList));
      }).catchError((error) {
        emit(GetTasksError(error: error.toString()));
      });
    } catch (e) {
      emit(GetTasksError(error: e.toString()));
    }
  }

//============================ delete task

  void deletTask({required TasksModel tasksModel}) {
    try {
      emit(DeletTaskLoading());
      tasksHistoryRepository
          .deletTask(tasksModel: tasksModel)
          .then((categoriesList) {
        emit(DeletTaskSuccess());
      }).catchError((error) {
        emit(DeletTaskError(error: error.toString()));
      });
    } catch (e) {
      emit(DeletTaskError(error: e.toString()));
    }
  }

  //===================== get categories Value in History screen per Item
  String getCategoryValue({required int key}) {
    try {
      var categoriesValue =
          tasksHistoryRepository.getCategoryValueNameHistory(key: key);

      return categoriesValue;
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  //===================== get categories value in detailes per object

  void getCategoryNameValue({required int key}) {
    try {
      emit(GetCategoryNameLoading());
      tasksHistoryRepository.getCategoryValue(key: key).then((categoryName) {
        emit(GetCategorySuccessName(categoryName: categoryName));
      }).catchError((error) {
        emit(GetCategoryErrorName(error: error.toString()));
      });
    } catch (e) {
      emit(GetCategoryErrorName(error: e.toString()));
    }
  }

//====================== Edit Task Action Icon
  void editTaskActionIcon() {
    emit(EditTaskActionSuccess());
  }

//============================== Save Edit Task

  Future editTask({
    required String taskTitle,
    required String dueDate,
    required bool isCompleted,
    required int categoryId,
    required bool remindMe,
    required String reminderDate,
    required String reminderTime,
    required TasksModel taskModel,
  }) async {
    try {
      emit(EditTaskLoading());
      await tasksHistoryRepository
          .editTask(
              taskTitle: taskTitle,
              dueDate: dueDate,
              isCompleted: isCompleted,
              categoryId: categoryId,
              remindMe: remindMe,
              reminderDate: reminderDate,
              reminderTime: reminderTime,
              taskModel: taskModel)
          .then((categoriesList) {
        emit(EditTaskSuccess());
      }).catchError((error) {
        print(error.toString());
        emit(EditTaskError(error: error.toString()));
      });
    } catch (e) {
      print(e.toString());
      emit(EditTaskError(error: e.toString()));
    }
  }

//=============================== get categories
  void getCategories() {
    try {
      emit(GetCategoriesLoading());
      tasksHistoryRepository.getCategories().then((categoriesList) {
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

  //====================================== Notification calling remind Me

  Future<void> callNotificationRemindMe(
      {required int hoursFromNow,
      required String heroThumbUrl,
      required String username,
      required String title,
      required String msg,
      required int seconds,
      required int minutes,
      required int days,
      required context}) async {
    await tasksHistoryRepository.callNotificationRemindMe(
        hoursFromNow: hoursFromNow,
        heroThumbUrl: heroThumbUrl,
        username: username,
        title: title,
        msg: msg,
        seconds: seconds,
        minutes: minutes,
        days: days,
        context: context);
  }

  //========================== Show Date Times Picker
  String? reminderTime;

  Future<DateTime?> showDateTimePicker({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    initialDate ??= DateTime.now();
    firstDate ??= initialDate.subtract(const Duration(days: 365 * 100));
    lastDate ??= firstDate.add(const Duration(days: 365 * 200));

    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (selectedDate == null) return null;

    if (!context.mounted) return selectedDate;

    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDate),
    );

    reminderTime = selectedTime?.format(context);
    return selectedTime == null
        ? selectedDate
        : DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );
  }

//=========================== Filterwd Tasks By Deu Date
  void filterTasksByDeuDate() {
    emit(FilterByDeuDateSuccess());
  }

//============================= Completed Task
  void completedTask({required TasksModel tasksModel}) {
    emit(CompletedTaskScuccess(tasksModel: tasksModel));
  }

//=========================== Get Tasks Filtered

  void getTasksFilterd() {
    try {
      emit(GetTaksFilteredLoading());
      tasksHistoryRepository.getTasks().then((tasksList) {
        emit(GetTasksFilteredSuccess(tasksList: tasksList));
      }).catchError((error) {
        emit(GetTasksFilteredError(error: error.toString()));
      });
    } catch (e) {
      emit(GetTasksFilteredError(error: e.toString()));
    }
  }

  // bool isDark = false;
  // void changeAppMode({bool? isDarkFromShared}) {
  //   emit(AppChangeModeLoadingState());
  //   if (isDarkFromShared != null) {
  //     isDark = isDarkFromShared;
  //     emit(AppChangeModeState());
  //   } else {
  //     isDark = !isDark;
  //     CacheHelper.putData(key: 'isDark', value: isDark).then((value) {});
  //     emit(AppChangeModeState());
  //   }
  // }
}
