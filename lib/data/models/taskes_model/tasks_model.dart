import 'package:hive/hive.dart';

part 'tasks_model.g.dart';

@HiveType(typeId: 1)
class TasksModel extends HiveObject {
  @HiveField(0)
  String taskTitle;

  @HiveField(1)
  String dueDate;

  @HiveField(2)
  bool isCompleted;

  @HiveField(3)
  int categoryId;

  @HiveField(4)
  bool remindMe;

  @HiveField(5)
  String reminderDate;

  @HiveField(6)
  String reminderTime;

  TasksModel({
    required this.taskTitle,
    required this.dueDate,
    required this.isCompleted,
    required this.categoryId,
    required this.remindMe,
    required this.reminderDate,
    required this.reminderTime,
  });
}
