import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
    // .then((value) {
    //   reminderTime = value!.format(context);

    // });
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
    await tasksRepository.callNotificationRemindMe(
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
}
