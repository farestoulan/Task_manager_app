import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_app/business_logic/tasks_cubit/tasks_state.dart';
import 'package:task_manager_app/core/app_strings/app_strings.dart';
import 'package:task_manager_app/core/reusable_component/toast_component.dart';
import '../../../business_logic/tasks_cubit/tasks_cubit.dart';
import '../../../core/reusable_component/loading_dialog.dart';
import '../../../core/reusable_component/success_alert.dart';
import '../../../data/models/categories_model/categories_model.dart';
import '../../widgets/add_tasks_widgets.dart/add_tasks_widgets.dart';
import 'package:task_manager_app/injection_container.dart' as di;

class CreateTaskScreen extends StatefulWidget {
  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  TextEditingController addTaskTitleController = TextEditingController();

  TextEditingController dateController = TextEditingController();
  TextEditingController reminderTimeController = TextEditingController();
  TextEditingController reminderDateController = TextEditingController();

  String? categoryDropDown;

  List<CategoriesModel> categoriesList = [];

  List<String> dropDownItems = [];

  int categoryKey = 0;
  bool? isReminder = false;
  bool? isChecked = false;
  DateTime? dateValue;
  bool enableValidation = true;
  bool isSelectDateAndTime = false;

  int days = 0;
  int hours = 0;
  int minutes = 0;
  int seconds = 0;
  String? reminderDate;
  final loginFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    addTaskTitleController.dispose();
    dateController.dispose();
    reminderTimeController.dispose();
    reminderDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    var width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (BuildContext context) => di.sl<TasksCubit>()..getCategories(),
      child: BlocConsumer<TasksCubit, TasksState>(
        listener: (context, state) async {
          if (state is GetCategoriesSuccess) {
            categoriesList = state.categoriesList;
            categoriesList.forEach((element) {
              dropDownItems.add(element.categoryName);
            });
          }

          if (state is GetCategoryKeySuccess) {
            categoryKey = state.key;

            print('categoryKey: $categoryKey');
          }

          if (state is AddTaskSuccess) {
//======================= call notification reminder Me
            if (isSelectDateAndTime == true) {
              await TasksCubit.get(context).callNotificationRemindMe(
                  context: context,
                  days: days,
                  hoursFromNow: hours,
                  minutes: minutes + 1,
                  msg: '',
                  seconds: 0,
                  title: '',
                  username: '',
                  heroThumbUrl: '');
            }

            successAlert(
              content: AppStrings.successTaskMassage,
              ctx: context,
              width: width,
            );
            await Future.delayed(const Duration(seconds: 1));
            Navigator.pop(context);
            addTaskTitleController.clear();
            dateController.clear();
            reminderTimeController.clear();
            reminderDateController.clear();
            setState(() {
              isChecked = false;
              enableValidation = true;
              isReminder = false;
              isSelectDateAndTime = false;
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
                      AppStrings.TaskScreenTitle,
                      style: Theme.of(context).appBarTheme.titleTextStyle,
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Form(
                      autovalidateMode: enableValidation
                          ? AutovalidateMode.disabled
                          : AutovalidateMode.onUserInteraction,
                      key: loginFormKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AddTasksWidgets.buildAddTaskBody(
                              onChangeTaskTitleTextFeild: (selectValue) {
                                setState(() {
                                  if (selectValue.isNotEmpty) {
                                    enableValidation = false;
                                  } else {
                                    enableValidation = true;
                                  }
                                });
                              },
                              isReminder: isReminder,
                              categoryDropDown: categoryDropDown,
                              height: height,
                              width: width,
                              addTaskTitleController: addTaskTitleController,
                              context: context,
                              dateController: dateController,
                              isChecked: isChecked,
//=========================== Reminder Date And Time
                              onTapReminderDateAndTime: () async {
                                isSelectDateAndTime = true;
                                DateTime dateTime =
                                    await TasksCubit.get(context)
                                            .showDateTimePicker(
                                                context: context) ??
                                        DateTime.now();

                                reminderDate =
                                    DateFormat("yyyy-MM-dd").format(dateTime);
//============================= currunt date

                                String date = DateFormat("yyyy-MM-dd hh:mm:ss")
                                    .format(DateTime.now());
                                DateTime curruentDate =
                                    new DateFormat("yyyy-MM-dd hh:mm:ss")
                                        .parse(date);
                                days = dateTime.difference(curruentDate).inDays;

                                hours =
                                    (dateTime.difference(curruentDate).inHours /
                                            60)
                                        .round();
                                minutes = (dateTime
                                        .difference(curruentDate)
                                        .inMinutes %
                                    60);
                                //seconds = curruentDate.difference(dateTime).inSeconds;

                                print(' dasy $days');
                                print(' hours $hours');
                                print(' minutes ${minutes + 1}');
                                print(' seconds $seconds');
                                print('curruentDate : $curruentDate');
                                print('dateTime : $dateTime');
                              },
//===========================  on Tap Checked
                              onTapChecked: (selectValue) {
                                setState(() {
                                  isChecked = selectValue;
                                  if (selectValue == true) {
                                    isReminder = selectValue;
                                  } else {
                                    isReminder = selectValue;
                                  }
                                });
                              },
//===================== Select Category from dropdown
                              onChangeDropDownCategory: (value) {
                                setState(() {
                                  categoryDropDown = value;

                                  TasksCubit.get(context).getCategoryKey(
                                    categoriesList: categoriesList,
                                    categoryNameSelected: value,
                                  );
                                });
                              },
//======================== BTN Save Task
                              onTapAddNew: () async {
                                enableValidation = true;
                                if (loginFormKey.currentState?.validate() ==
                                    true) {
                                  if (addTaskTitleController.text.isNotEmpty &&
                                      dateController.text.isNotEmpty &&
                                      categoryDropDown != null) {
                                    if (isReminder! == true) {
                                      if (reminderDate != null &&
                                          TasksCubit.get(context)
                                                  .reminderTime !=
                                              null) {
                                        TasksCubit.get(context).addTask(
                                          taskTitle:
                                              addTaskTitleController.text,
                                          dueDate: dateController.text,
                                          isCompleted: false,
                                          categoryId: categoryKey,
                                          remindMe: isReminder!,
                                          reminderDate: reminderDate!,
                                          reminderTime: TasksCubit.get(context)
                                              .reminderTime!,
                                        );
                                      } else {
                                        showToast(
                                            msg: AppStrings
                                                .interDateAndTimerequiredMassage,
                                            context: context,
                                            width: width);
                                      }
                                    } else {
                                      TasksCubit.get(context).addTask(
                                        taskTitle: addTaskTitleController.text,
                                        dueDate: dateController.text,
                                        isCompleted: false,
                                        categoryId: categoryKey,
                                        remindMe: isReminder!,
                                        reminderDate: reminderDate ?? '',
                                        reminderTime: TasksCubit.get(context)
                                                .reminderTime ??
                                            '',
                                      );
                                    }
                                  } else {
                                    showToast(
                                        msg: AppStrings
                                            .interDueDaterequiredMassage,
                                        context: context,
                                        width: width);
                                  }
                                } else {
                                  showToast(
                                      msg: AppStrings
                                          .interDueDaterequiredMassage,
                                      context: context,
                                      width: width);
                                }
                              },
                              itemsDropDownList: dropDownItems,
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
              LoadingDialog(isLoading: state is GetCategoriesLoading),
            ],
          );
        },
      ),
    );
  }
}
