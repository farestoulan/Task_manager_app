import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_app/business_logic/tasks_history_cubit/tasks_history_cubit.dart';
import 'package:task_manager_app/business_logic/tasks_history_cubit/tasks_history_state.dart';
import '../../../config/app/routes/app_routes.dart';
import '../../../core/app_strings/app_strings.dart';
import '../../../core/reusable_component/date_picker.dart';
import '../../../core/reusable_component/loading_dialog.dart';
import '../../../core/reusable_component/remove_alert.dart';
import '../../../core/reusable_component/toast_component.dart';
import '../../../core/utils/styles/color/color_manger.dart';
import '../../../core/utils/styles/fonts/style_fonts.dart';
import '../../../data/models/taskes_model/tasks_model.dart';
import '../../widgets/tasks_history_widgets/tasks_history_widgets.dart';
import 'package:task_manager_app/injection_container.dart' as di;

class TasksHistoryScreen extends StatefulWidget {
  @override
  State<TasksHistoryScreen> createState() => _TasksHistoryScreenState();
}

class _TasksHistoryScreenState extends State<TasksHistoryScreen> {
  List<TasksModel> tasksList = [];
  List<String> CategoryNamelist = [];
  String categoryName = '';
  List<TasksModel> filteredByDeuDate = [];
  TextEditingController dueDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    var width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (BuildContext context) => di.sl<TasksHistoryCubit>()..getTasks(),
      child: BlocConsumer<TasksHistoryCubit, TasksHistoryState>(
        listener: (context, state) async {
          if (state is GetTasksSuccess) {
            tasksList = state.tasksList;
          }
          if (state is DeletTaskSuccess) {
            TasksHistoryCubit.get(context).getTasks();
            showToast(
                msg: AppStrings.massageDeletedTask,
                context: context,
                width: width);
          }

          if (state is FilterByDeuDateSuccess) {
            TasksHistoryCubit.get(context).getTasksFilterd();
          }
          if (state is GetTasksFilteredSuccess) {
            tasksList = state.tasksList;
            setState(() {
              filteredByDeuDate = tasksList
                  .where((element) => element.dueDate == dueDateController.text)
                  .toList();
              print('filteredByDeuDate :${filteredByDeuDate.length}');
              tasksList = filteredByDeuDate;
            });
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
          return Stack(
            children: [
              Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    title: Text(
                      AppStrings.taskHistoryScreenTitle,
                      style: Theme.of(context).appBarTheme.titleTextStyle,
                    ),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
//=========================== Text Feild Dueo Date

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: ColorManager.lightGreen,
                                    borderRadius: BorderRadius.circular(15)),
                                height: height / 15,
                                width: width / 4,
                                child: TextButton(
                                  onPressed: () {
                                    TasksHistoryCubit.get(context).getTasks();
                                    dueDateController.clear();
                                  },
                                  child: Text(
                                    AppStrings.restbTn,
                                    style: getMediumStyle(
                                        color: ColorManager.green,
                                        fontFamily: AppStrings.gilroyMedium),
                                  ),
                                )),
                            SizedBox(
                              width: width / 1.8,
                              child: DatePicker.buildDatePicker(
                                hintText: AppStrings.filterDueDate,
                                togglePassword: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(DateTime.now().day),
                                    lastDate: DateTime(DateTime.now().year + 1),
                                    builder: (context, child) => Theme(
                                      data: ThemeData().copyWith(
                                        colorScheme: ColorScheme.light(
                                          primary: ColorManager.primary,
                                        ),
                                      ),
                                      child: child!,
                                    ),
                                  ).then(
                                    (value) {
                                      var formatter =
                                          new DateFormat('yyyy-MM-dd', 'en');
                                      String formattedDate =
                                          formatter.format(value!);
                                      dueDateController.text = formattedDate;
                                      TasksHistoryCubit.get(context)
                                          .filterTasksByDeuDate();
                                    },
                                  );
                                },
                                dateController: dueDateController,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height / 20,
                        ),
                        Divider(color: ColorManager.grey3),

//============================= List Of Tasks
                        Flexible(
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return TasksHistoryWidgets.buildItemInListTasks(
                                categoryName: TasksHistoryCubit.get(context)
                                    .getCategoryValue(
                                        key: tasksList[index].categoryId),
                                height: height,
                                width: width,
                                tasksList: tasksList,
                                index: index,
//================================= Completed Task
                                onTapCompleted: () {
                                  removeAlert(
                                      ctx: context,
                                      height: height,
                                      width: width,
                                      content:
                                          'Are You Sure Completed This Task(${tasksList[index].taskTitle}) ?',
                                      doneFunction: () {
                                        Navigator.pop(context);
                                        TasksHistoryCubit.get(context)
                                            .completedTask(
                                                tasksModel: tasksList[index]);
                                      });
                                },
//================================== Delet Task
                                onTapDelet: () {
                                  removeAlert(
                                      ctx: context,
                                      height: height,
                                      width: width,
                                      content:
                                          'Do You want Delet This Task( ${tasksList[index].taskTitle} )?',
                                      doneFunction: () {
                                        Navigator.pop(context);
                                        TasksHistoryCubit.get(context)
                                            .deletTask(
                                                tasksModel: tasksList[index]);
                                      });
                                },
                                onTapEdit: () {
                                  Routes.navigateAndPushArgs(
                                      context,
                                      Routes.ditTasksDetailesScreen,
                                      tasksList[index]);
                                },
//============================ Go Task Detailes
                                onTapItem: () {
                                  Routes.navigateAndPushArgs(
                                      context,
                                      Routes.tasksDetailesScreen,
                                      tasksList[index]);
                                },
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(),
                            itemCount: tasksList.length,
                          ),
                        )
                      ],
                    ),
                  )),
              LoadingDialog(isLoading: state is GetTaksLoading),
            ],
          );
        },
      ),
    );
  }
}
