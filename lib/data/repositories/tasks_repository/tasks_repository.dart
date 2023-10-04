import 'package:task_manager_app/data/models/taskes_model/tasks_model.dart';

import '../../../boxes_cach.dart';
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
}
