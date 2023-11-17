import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/business_logic/search_bloc/search_event.dart';
import 'package:task_manager_app/business_logic/tasks_history_cubit/tasks_history_state.dart';

import '../../../business_logic/search_bloc/search_bloc.dart';
import '../../../business_logic/search_bloc/search_state.dart';
import '../../../business_logic/tasks_history_cubit/tasks_history_cubit.dart';
import '../../../config/app/routes/app_routes.dart';
import '../../../core/reusable_component/remove_alert.dart';
import '../../../data/models/taskes_model/tasks_model.dart';
import '../tasks_history_widgets/tasks_history_widgets.dart';
import 'custom_search_text_field.dart';
import 'package:task_manager_app/injection_container.dart' as di;

class SearchViewBody extends StatelessWidget {
  SearchViewBody({super.key});
  TextEditingController textEditingController = TextEditingController();
  List<TasksModel> searchedTasksList = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => di.sl<SearchBloc>(),
      child: BlocConsumer<SearchBloc, SearchState>(
        listener: (context, state) {
          if (state is SearchTextTaskNameChangedSuccessState) {
            searchedTasksList = state.searchedTasksList;
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSearchTextField(
                  textEditingController: textEditingController,
                  onchange: (value) {
                    BlocProvider.of<SearchBloc>(context).add(
                        SearchTextTaskNameChangedEvent(
                            searchedTextTaskNameChanged: value!));
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Search Result',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: SearchResultListView(
                      searchedTasksList: searchedTasksList),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class SearchResultListView extends StatelessWidget {
  SearchResultListView({super.key, required this.searchedTasksList});
  List<TasksModel> searchedTasksList;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    var width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (BuildContext context) => di.sl<TasksHistoryCubit>()..getTasks(),
      child: BlocConsumer<TasksHistoryCubit, TasksHistoryState>(
        listener: (context, state) {
          if (state is GetTasksSuccess) {
            searchedTasksList = state.tasksList;
          }
          if (state is CompletedTaskScuccess) {
            TasksHistoryCubit.get(context).editTask(
                taskTitle: state.tasksModel.taskTitle,
                dueDate: state.tasksModel.dueDate,
                isCompleted: true,
                categoryId: state.tasksModel.categoryId,
                remindMe: state.tasksModel.remindMe,
                reminderDate: state.tasksModel.reminderDate,
                reminderTime: state.tasksModel.reminderTime,
                taskModel: state.tasksModel);
          }
          if (state is EditTaskSuccess) {
            TasksHistoryCubit.get(context).getTasks();
          }
        },
        builder: (context, state) {
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: searchedTasksList.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: TasksHistoryWidgets.buildItemInListTasks(
                    categoryName: TasksHistoryCubit.get(context)
                        .getCategoryValue(
                            key: searchedTasksList[index].categoryId),
                    height: height,
                    width: width,
                    tasksList: searchedTasksList,
                    index: index,
//================================= Completed Task
                    onTapCompleted: () {
                      removeAlert(
                          ctx: context,
                          height: height,
                          width: width,
                          content:
                              'Are You Sure Completed This Task(${searchedTasksList[index].taskTitle}) ?',
                          doneFunction: () {
                            Navigator.pop(context);
                            TasksHistoryCubit.get(context).completedTask(
                                tasksModel: searchedTasksList[index]);
                          });
                    },
//================================== Delet Task
                    onTapDelet: () {
                      removeAlert(
                          ctx: context,
                          height: height,
                          width: width,
                          content:
                              'Do You want Delet This Task( ${searchedTasksList[index].taskTitle} )?',
                          doneFunction: () {
                            Navigator.pop(context);
                            TasksHistoryCubit.get(context).deletTask(
                                tasksModel: searchedTasksList[index]);
                          });
                    },
                    onTapEdit: () {
                      Routes.navigateAndPushArgs(
                          context,
                          Routes.ditTasksDetailesScreen,
                          searchedTasksList[index]);
                    },
//============================ Go Task Detailes
                    onTapItem: () {
                      Routes.navigateAndPushArgs(context,
                          Routes.tasksDetailesScreen, searchedTasksList[index]);
                    },
                  )
                  //child: Text('data'),
                  );
            },
          );
        },
      ),
    );
  }
}
