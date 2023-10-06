import 'package:task_manager_app/data/models/taskes_model/tasks_model.dart';

import '../../../boxes_cach.dart';
import '../../../core/notification_service/notification_service.dart';
import '../../models/categories_model/categories_model.dart';

class TasksHistoryRepository {
  //=========================== get Tasks
  Future<List<TasksModel>> getTasks() async {
    try {
      List<TasksModel> tasksLisBox = [];

      tasksLisBox = Boxes.getTasks().values.toList();
//===================== Sorted List per category
      tasksLisBox.sort((a, b) {
        return a.categoryId.compareTo(b.categoryId);
      });

      return tasksLisBox;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //========================= delet Task
  Future deletTask({required TasksModel tasksModel}) async {
    try {
      final box = Boxes.getTasks();
      box.delete(tasksModel.key);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

//=========================== get categories value in detailes per object
  Future<String> getCategoryValue({required int key}) async {
    try {
      CategoriesModel? categoriesValue;
      categoriesValue = Boxes.getCategories().get(key);

      return categoriesValue!.categoryName;
    } catch (e) {
      return e.toString();
    }
  }

//=========================== get categories Value in History screen per Item
  String getCategoryValueNameHistory({required int key}) {
    try {
      CategoriesModel? categoriesValue;
      categoriesValue = Boxes.getCategories().get(key);

      return categoriesValue!.categoryName;
    } catch (e) {
      return e.toString();
    }
  }

//========================= Edit Task
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
      final box = Boxes.getTasks();
      box.put(
        taskModel.key,
        TasksModel(
          taskTitle: taskTitle,
          dueDate: dueDate,
          isCompleted: isCompleted,
          categoryId: categoryId,
          remindMe: remindMe,
          reminderDate: reminderDate,
          reminderTime: reminderTime,
        ),
      );
    } catch (e) {
      return Future.error(e.toString());
    }
  }

//=========================== get Categories
  Future<List<CategoriesModel>> getCategories() async {
    try {
      List<CategoriesModel> categoriesLisBox = [];

      categoriesLisBox = Boxes.getCategories().values.toList();

      return categoriesLisBox;
    } catch (e) {
      return Future.error(e.toString());
    }
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
    await NotificationController.scheduleNewNotification(
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
