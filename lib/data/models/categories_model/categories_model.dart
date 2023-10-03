import 'package:hive/hive.dart';

part 'categories_model.g.dart';

@HiveType(typeId: 0)
class CategoriesModel extends HiveObject {
  @HiveField(0)
  String categoryName;

  CategoriesModel({required this.categoryName});
}
