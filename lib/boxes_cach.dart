import 'package:hive/hive.dart';
import 'package:task_manager_app/data/models/taskes_model/tasks_model.dart';

import 'data/models/categories_model/categories_model.dart';

class Boxes {
  //======================= Categories Box
  static Box<CategoriesModel> getCategories() =>
      Hive.box<CategoriesModel>('Categories');
//========================= Tasks Box
  static Box<TasksModel> getTasks() => Hive.box<TasksModel>('Tasks');
}
