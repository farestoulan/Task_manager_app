import '../../../boxes_cach.dart';
import '../../models/categories_model/categories_model.dart';
import '../../models/taskes_model/tasks_model.dart';

class CategoriesRepository {
//=========================== Add Categories
  Future addCategories({required String categoryName}) async {
    try {
      final categoriesModel = CategoriesModel(categoryName: categoryName);
      final box = Boxes.getCategories();
      box.add(categoriesModel);
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

//========================= delet Categories
  Future deletCategories({required CategoriesModel categoriesModel}) async {
    try {
      final box = Boxes.getCategories();
      box.delete(categoriesModel.key);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

//========================= Edit Categories
  Future editCategories(
      {required String categoryValueEdited,
      required CategoriesModel categoriesModel}) async {
    try {
      final box = Boxes.getCategories();
      box.put(categoriesModel.key,
          CategoriesModel(categoryName: categoryValueEdited));
    } catch (e) {
      return Future.error(e.toString());
    }
  }

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
}
