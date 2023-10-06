import 'package:task_manager_app/data/models/taskes_model/tasks_model.dart';

import '../../../boxes_cach.dart';
import '../../../core/notification_service/notification_service.dart';
import '../../models/categories_model/categories_model.dart';

class TasksRepository {
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

//=========================== Add Tasks
  Future addTasks({
    required String taskTitle,
    required String dueDate,
    required bool isCompleted,
    required int categoryId,
    required bool remindMe,
    required String reminderDate,
    required String reminderTime,
  }) async {
    try {
      final tasksModel = TasksModel(
        taskTitle: taskTitle,
        dueDate: dueDate,
        isCompleted: isCompleted,
        categoryId: categoryId,
        remindMe: remindMe,
        reminderDate: reminderDate,
        reminderTime: reminderTime,
      );
      final box = Boxes.getTasks();
      box.add(tasksModel);
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
