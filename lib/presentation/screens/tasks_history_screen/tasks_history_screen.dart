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
            setState(() {
              filteredByDeuDate = tasksList
                  .where((element) => element.dueDate == dueDateController.text)
                  .toList();
              print('filteredByDeuDate :${filteredByDeuDate.length}');
              tasksList = filteredByDeuDate;
            });
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    title: Text(
                      'Tasks History',
                      style: Theme.of(context).appBarTheme.titleTextStyle,
                    ),
                    actions: [
                      // IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                      // IconButton(
                      //     onPressed: () {
                      //       AppCubit.get(context).changeAppMode();
                      //     },
                      //     icon: const Icon(Icons.brightness_4_outlined))
                    ],
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        //========================== Text Feild Dueo Date

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
                                  },
                                  child: Text(
                                    'Rest',
                                    style: getMediumStyle(
                                        color: ColorManager.green,
                                        fontFamily: AppStrings.gilroyMedium),
                                  ),
                                )),
                            SizedBox(
                              width: width / 1.8,
                              child: DatePicker.buildDatePicker(
                                hintText: 'Filter by deu date',
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

                        //===================== List Of Tasks
                        Expanded(
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
                                //======================== Delet Task
                                onTapDelet: () {
                                  removeAlert(
                                      ctx: context,
                                      height: height,
                                      width: width,
                                      content: 'Do You want Delet Task?',
                                      doneFunction: () {
                                        Navigator.pop(context);
                                        TasksHistoryCubit.get(context)
                                            .deletTask(
                                                tasksModel: tasksList[index]);
                                      });
                                },
                                onTapEdit: () {},
                                //====================== Go Task Detailes
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
