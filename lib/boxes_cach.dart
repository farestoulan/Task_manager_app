import 'package:hive/hive.dart';

import 'data/models/categories_model/categories_model.dart';

class Boxes {
  static Box<CategoriesModel> getCategories() =>
      Hive.box<CategoriesModel>('Categories');
}
