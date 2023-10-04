import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_app/business_logic/tasks_cubit/tasks_state.dart';
import 'package:task_manager_app/core/app_strings/app_strings.dart';
import 'package:task_manager_app/core/reusable_component/toast_component.dart';
import '../../../business_logic/tasks_cubit/tasks_cubit.dart';
import '../../../config/app/routes/app_routes.dart';
import '../../../core/reusable_component/success_alert.dart';
import '../../../core/utils/styles/color/color_manger.dart';
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

  DateTime? timeValue;

  int hours = 0;

  // int daysBetween(DateTime from, DateTime to) {
  //   from = DateTime(from.year, from.month, from.day);
  //   to = DateTime(to.year, to.month, to.day);
  //   return (to.difference(from).inHours / 24).round();
  // }
  //    final date1 = DateTime.now();

  //                         var days = daysBetween(date1, dateValue!);
  //                         print('days:$days');

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
            successAlert(
              content: AppStrings.successMassage,
              ctx: context,
              width: width,
            );
            await Future.delayed(const Duration(seconds: 1));

            Routes.navigateAndFinish(context, Routes.tasksHomeScreen);
          }
        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: Text(
                  AppStrings.TaskScreenTitle,
                  style: Theme.of(context).appBarTheme.titleTextStyle,
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AddTasksWidgets.buildAddTaskBody(
                        isReminder: isReminder,
                        categoryDropDown: categoryDropDown,
                        height: height,
                        width: width,
                        addTaskTitleController: addTaskTitleController,
                        context: context,
                        dateController: dateController,
                        isChecked: isChecked,
//=========================== Reminder Date
                        onTapReminderDate: () {
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
                              dateValue = value;
                              var formatter =
                                  new DateFormat('yyyy-MM-dd', 'en');
                              String formattedDate = formatter.format(value!);
                              reminderDateController.text = formattedDate;
                              print(
                                  'reminderDateController:${reminderDateController.text}');
                            },
                          );
                        },
//===========================  Reminder Time
                        onTapReminderTime: () {
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          ).then((value) {
                            reminderTimeController.text =
                                value!.format(context);
                            print(
                                'reminderTimeController:${reminderTimeController.text}');
                          });
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
//======================== BTN Add New OnTap
                        onTapAddNew: () {
                          // NotificationController.scheduleNewNotification();
                          if (addTaskTitleController.text.isNotEmpty &&
                              dateController.text.isNotEmpty &&
                              categoryDropDown!.isNotEmpty) {
                            if (isReminder! == true) {
                              if (reminderDateController.text.isNotEmpty &&
                                  reminderTimeController.text.isNotEmpty) {
                                TasksCubit.get(context).addTask(
                                  taskTitle: addTaskTitleController.text,
                                  dueDate: dateController.text,
                                  isCompleted: false,
                                  categoryId: categoryKey,
                                  remindMe: isReminder!,
                                  reminderDate: reminderDateController.text,
                                  reminderTime: reminderTimeController.text,
                                );
                              } else {
                                showToast(
                                    msg: 'Please select date and time',
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
                                reminderDate: reminderDateController.text,
                                reminderTime: reminderTimeController.text,
                              );
                            }
                          } else {
                            showToast(
                                msg: 'Pleas Input requried data',
                                context: context,
                                width: width);
                          }
                        },
                        itemsDropDownList: dropDownItems,
                      )
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
