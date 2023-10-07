import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_app/business_logic/tasks_history_cubit/tasks_history_state.dart';
import 'package:task_manager_app/config/app/routes/app_routes.dart';
import 'package:task_manager_app/data/models/taskes_model/tasks_model.dart';
import '../../../business_logic/tasks_history_cubit/tasks_history_cubit.dart';
import '../../../core/app_strings/app_strings.dart';
import '../../../core/reusable_component/date_picker.dart';
import '../../../core/reusable_component/drop_down_list_componenet.dart';
import '../../../core/reusable_component/remove_alert.dart';
import '../../../core/reusable_component/success_alert.dart';
import '../../../core/reusable_component/toast_component.dart';
import '../../../core/reusable_component/txt_field_component.dart';
import '../../../core/utils/styles/color/color_manger.dart';
import 'package:task_manager_app/injection_container.dart' as di;
import '../../../data/models/categories_model/categories_model.dart';
import '../../widgets/task_detailes_widgets/task_detailes_widgets.dart';

class TaskDetailsScreen extends StatefulWidget {
  TasksModel? tasksModel;
  bool? isEditabel;
  TaskDetailsScreen({Key? key, this.tasksModel, this.isEditabel = false})
      : super(key: key);

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  TextEditingController addTaskTitleController = TextEditingController();

  TextEditingController categoryController = TextEditingController();

  TextEditingController dueDateController = TextEditingController();

  TextEditingController dateAndTimeController = TextEditingController();

  //bool isEditabel = false;

  String? categoryDropDown;

  List<String> itemsDropDownCategoriesList = [];

  List<CategoriesModel> categoriesList = [];

  DateTime? dateTime;

  String categoryName = '';

  bool isCheckedReminedMe = false;
  bool isCheckedChangeStatus = false;
  bool isSelectDateAndTime = false;

  int? categoryKey;

  int days = 0;
  int hours = 0;
  int minutes = 0;
  int seconds = 0;
  String? reminderDate;

//==================================
  @override
  void dispose() {
    addTaskTitleController.dispose();
    categoryController.dispose();
    dueDateController.dispose();
    dateAndTimeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    addTaskTitleController.text = widget.tasksModel!.taskTitle;
    dueDateController.text = widget.tasksModel!.dueDate;
    dateAndTimeController.text =
        widget.tasksModel!.reminderDate + " " + widget.tasksModel!.reminderTime;
    isCheckedReminedMe = widget.tasksModel!.remindMe;
    isCheckedChangeStatus = widget.tasksModel!.isCompleted;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    categoryController.text = categoryName;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (BuildContext context) => di.sl<TasksHistoryCubit>()
        ..getCategoryNameValue(key: widget.tasksModel!.categoryId),
      child: BlocConsumer<TasksHistoryCubit, TasksHistoryState>(
        listener: (context, state) async {
          if (state is DeletTaskSuccess) {
            Routes.navigateTo(context, Routes.tasksHomeScreen);
            showToast(
              msg: AppStrings.massageDeletedTask,
              context: context,
              width: width,
            );
          }
          if (state is EditTaskActionSuccess) {
            widget.isEditabel = true;
            TasksHistoryCubit.get(context).getCategories();
          }

          if (state is EditTaskSuccess) {
//======================= call notification reminder Me
            if (isSelectDateAndTime == true) {
              await TasksHistoryCubit.get(context).callNotificationRemindMe(
                context: context,
                days: days,
                hoursFromNow: hours,
                minutes: minutes + 1,
                msg:
                    "This Task ${addTaskTitleController.text} , Reminder Date is ${dateTime.toString()} ,And Reminder Time is ${TasksHistoryCubit.get(context).reminderTime ?? ''}",
                seconds: 0,
                title: addTaskTitleController.text,
                username: '',
                heroThumbUrl: '',
              );
            }
            successAlert(
              content: AppStrings.successMassageEdit,
              ctx: context,
              width: width,
            );
            await Future.delayed(const Duration(seconds: 1));

            Routes.navigateAndFinish(context, Routes.tasksHomeScreen);
          }

          if (state is GetCategorySuccessName) {
            setState(() {
              categoryName = state.categoryName;
            });
          }
          if (state is GetCategoriesSuccess) {
            categoriesList = state.categoriesList;
            categoriesList.forEach((element) {
              itemsDropDownCategoriesList.add(element.categoryName);
            });
            categoryDropDown = categoryName;
          }

          if (state is GetCategoryKeySuccess) {
            categoryKey = state.key;

            print('categoryKey: $categoryKey');
          }
        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: Text(AppStrings.taskDetailsTitle),
                automaticallyImplyLeading: false,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      TaskDetailesWidgets.buildRowEditAndDelet(
//=================Delet Task
                        onTapDelet: () {
                          removeAlert(
                              ctx: context,
                              height: height,
                              width: width,
                              content:
                                  'Do You want Delet Task (${widget.tasksModel!.taskTitle})?',
                              doneFunction: () {
                                Navigator.pop(context);
                                TasksHistoryCubit.get(context)
                                    .deletTask(tasksModel: widget.tasksModel!);
                              });
                        },
//====================== Edit Task
                        onTapEdit: () {
                          TasksHistoryCubit.get(context).editTaskActionIcon();
                        },
                      ),
                      // SizedBox(
                      //   height: height / 50,
                      // ),
//====================Task Title
                      CustomTxtField(
                        isDimed: false,
                        isEnabled: widget.isEditabel!,
                        togglePassword: () {},
                        hintText: AppStrings.hintTypingTask,
                        labelText: AppStrings.addTasksLabel,
                        controller: addTaskTitleController,
                        emptyErrMsg: 'teeeeest',
                        txtInputType: TextInputType.text,
                      ),

                      SizedBox(
                        height: height / 30,
                      ),
//==================== Category Drop down and Text Feild
                      widget.isEditabel == true
                          ? DropDownComponenet(
                              hint: AppStrings.selectCategory,
                              onChange: (value) {
                                setState(() {
                                  TasksHistoryCubit.get(context).getCategoryKey(
                                      categoriesList: categoriesList,
                                      categoryNameSelected: value);
                                  categoryDropDown = value;
                                });
                              },
                              itemsDropDownList: itemsDropDownCategoriesList,
                              selectedValue: categoryDropDown,
                            )
                          : CustomTxtField(
                              isDimed: false,
                              isEnabled: widget.isEditabel!,
                              togglePassword: () {},
                              hintText: AppStrings.categorylabel,
                              labelText: AppStrings.categorylabel,
                              controller: categoryController,
                              emptyErrMsg: 'teeeeest',
                              txtInputType: TextInputType.text,
                            ),

                      SizedBox(
                        height: height / 30,
                      ),
//========================== Text Feild Dueo Date
                      DatePicker.buildDatePicker(
                        isEditable: widget.isEditabel!,
                        hintText: AppStrings.selectDueDateLabel,
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
                              // var formatter = DateFormat.yMMMMd('en');
                              var formatter =
                                  new DateFormat('yyyy-MM-dd', 'en');
                              String formattedDate = formatter.format(value!);
                              dueDateController.text = formattedDate;
                            },
                          );
                        },
                        dateController: dueDateController,
                      ),
                      SizedBox(
                        height: height / 30,
                      ),
//====================== Check box Reminder
                      TaskDetailesWidgets.buildChechRemindMe(
                        isEditable: widget.isEditabel!,
                        isChecked: isCheckedReminedMe,
                        onTapChecked: (valueSelected) {
                          setState(() {
                            isCheckedReminedMe = valueSelected!;
                          });
                        },
                        width: width,
                      ),
                      SizedBox(
                        height: height / 30,
                      ),
//========================== Text Feild Date And Time
                      isCheckedReminedMe == true
                          ? DatePicker.buildDatePicker(
                              isEditable: widget.isEditabel!,
                              hintText: AppStrings.selectDateAndTime,
                              togglePassword: () async {
                                isSelectDateAndTime = true;
                                dateTime = await TasksHistoryCubit.get(context)
                                        .showDateTimePicker(context: context) ??
                                    DateTime.now();
                                dateAndTimeController.text =
                                    dateTime.toString();

                                reminderDate =
                                    DateFormat("yyyy-MM-dd").format(dateTime!);
//============================= currunt date

                                String date = DateFormat("yyyy-MM-dd hh:mm:ss")
                                    .format(DateTime.now());
                                DateTime curruentDate =
                                    new DateFormat("yyyy-MM-dd hh:mm:ss")
                                        .parse(date);
                                days =
                                    dateTime!.difference(curruentDate).inDays;

                                hours = (dateTime!
                                            .difference(curruentDate)
                                            .inHours /
                                        60)
                                    .round();
                                minutes = (dateTime!
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
                              dateController: dateAndTimeController,
                            )
                          : Container(),
                      SizedBox(
                        height: height / 30,
                      ),
//============================ change Status
                      TaskDetailesWidgets.buildChangeStatus(
                        width: width,
                        isChecked: isCheckedChangeStatus,
                        onTapChecked: (isCheckedChange) {
                          setState(() {
                            isCheckedChangeStatus = isCheckedChange!;
                          });
                        },
                        isEditable: widget.isEditabel!,
                      ),
                      SizedBox(
                        height: height / 30,
                      ),
//======================= BTN Save Editing
                      widget.isEditabel! == true
                          ? TaskDetailesWidgets.buildBTNSaveTask(
                              height: height,
                              width: width,
//===================== Edit Task
                              editTask: () async {
                                await TasksHistoryCubit.get(context).editTask(
                                  taskTitle: addTaskTitleController.text,
                                  dueDate: dueDateController.text,
                                  isCompleted: isCheckedChangeStatus,
                                  categoryId: categoryKey ??
                                      widget.tasksModel!.categoryId,
                                  remindMe: isCheckedReminedMe,
                                  reminderDate: reminderDate ??
                                      widget.tasksModel!.reminderDate,
                                  reminderTime: TasksHistoryCubit.get(context)
                                          .reminderTime ??
                                      widget.tasksModel!.reminderTime,
                                  taskModel: widget.tasksModel!,
                                );
                              },
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
//=========================== BTN Back Home
              bottomNavigationBar: TaskDetailesWidgets.buildBackButton(
                width: width,
                onTapBackButton: () {
                  Routes.navigateTo(context, Routes.tasksHomeScreen);
                },
              ));
        },
      ),
    );
  }
}
