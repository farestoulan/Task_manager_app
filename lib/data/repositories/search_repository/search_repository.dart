import '../../../boxes_cach.dart';
import '../../models/taskes_model/tasks_model.dart';

class SearchRepository {
  //=========================== get Tasks
  Future<List<TasksModel>> getTasks(
      {required String searchedTextTaskNameChanged}) async {
    try {
      List<TasksModel> tasksLisBox = [];

//===================== Searched with charcter
      tasksLisBox = Boxes.getTasks().values.toList();
      List<TasksModel> tasksSearchedLisBox = [];
      tasksSearchedLisBox = tasksLisBox
          .where((element) => element.taskTitle
              .toLowerCase()
              .startsWith(searchedTextTaskNameChanged))
          .toList();
      print('Tessssssssssssst : ${tasksLisBox.length}');
      return tasksSearchedLisBox;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
