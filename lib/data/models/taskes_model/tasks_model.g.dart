// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TasksModelAdapter extends TypeAdapter<TasksModel> {
  @override
  final int typeId = 1;

  @override
  TasksModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TasksModel(
      taskTitle: fields[0] as String,
      dueDate: fields[1] as String,
      isCompleted: fields[2] as bool,
      categoryId: fields[3] as int,
      remindMe: fields[4] as bool,
      reminderDate: fields[5] as String,
      reminderTime: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TasksModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.taskTitle)
      ..writeByte(1)
      ..write(obj.dueDate)
      ..writeByte(2)
      ..write(obj.isCompleted)
      ..writeByte(3)
      ..write(obj.categoryId)
      ..writeByte(4)
      ..write(obj.remindMe)
      ..writeByte(5)
      ..write(obj.reminderDate)
      ..writeByte(6)
      ..write(obj.reminderTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TasksModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
