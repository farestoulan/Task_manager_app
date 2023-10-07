import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:task_manager_app/core/utils/styles/fonts/font_maneger.dart';
import '../../../core/app_strings/app_strings.dart';
import '../../../core/utils/styles/color/color_manger.dart';
import '../../../core/utils/styles/fonts/style_fonts.dart';
import '../../../data/models/taskes_model/tasks_model.dart';

class TasksHistoryWidgets {
  static Widget buildItemInListTasks({
    required double height,
    required double width,
    required List<TasksModel> tasksList,
    required int index,
    required Function onTapDelet,
    required Function onTapEdit,
    required Function onTapCompleted,
    required Function onTapItem,
    required String categoryName,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Slidable(
        // Specify a key if the Slidable is dismissible.
        key: const ValueKey(0),

        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),

          // A pane can dismiss the Slidable.
          //***** */ dismissible: DismissiblePane(onDismissed: () {}),

          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
//========================== Delet Icon
            SlidableAction(
              borderRadius: BorderRadius.circular(20),
              onPressed: (context) {
                onTapDelet();
              },
              backgroundColor: ColorManager.redColor,
              foregroundColor: ColorManager.whiteColor,
              icon: Icons.delete,
              //label: AppStrings.deleteLabel,
            ),

            SizedBox(
              width: width / 30,
            ),
//========================== Edit Icon
            SlidableAction(
              borderRadius: BorderRadius.circular(20),
              onPressed: (context) {
                onTapEdit();
              },
              backgroundColor: ColorManager.grey1,
              foregroundColor: ColorManager.whiteColor,
              icon: Icons.edit,
              //label: AppStrings.editLabel,
            ),
            SizedBox(
              width: width / 30,
            ),
//========================== Completed Icon
            SlidableAction(
              borderRadius: BorderRadius.circular(20),
              onPressed: (context) {
                onTapCompleted();
              },
              backgroundColor: ColorManager.green,
              foregroundColor: ColorManager.whiteColor,
              icon: Icons.check,
              //label: AppStrings.editLabel,
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            onTapItem();
          },
          child: Card(
            shadowColor: ColorManager.shadowColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            elevation: 5.0,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorManager.primary,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.task_outlined,
                              size: 40,
                            ),
                          ),
                        ),
                        Spacer(),
//========================Task title
                        Container(
                          width: width / 3,
                          child: Text(
                            tasksList[index].taskTitle,
                            style: TextStyle(
                              //fontStyle: FontStyle.italic,
                              fontSize: 17,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Spacer(),
//============================ is Completed
                        tasksList[index].isCompleted == false
                            ? Container(
                                height: height / 30,
                                width: width / 5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: ColorManager.lightGreen2),
                                child: Center(
                                  child: Text(
                                    AppStrings.newStatus,
                                    style: getRegularStyle(
                                        color: ColorManager.primary,
                                        fontFamily: AppStrings.gilroyRegular),
                                  ),
                                ),
                              )
                            : Container(
                                height: height / 30,
                                width: width / 5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: ColorManager.redColorCompleted),
                                child: Center(
                                  child: Text(
                                    AppStrings.completedStatus,
                                    style: getRegularStyle(
                                        color: ColorManager.whiteColor,
                                        fontFamily: AppStrings.gilroyRegular,
                                        fontSize: FontSize.s16),
                                  ),
                                ),
                              ),
                      ],
                    ),
                    SizedBox(
                      height: height / 60,
                    ),
//============================ Category Name

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width / 4.5,
                        ),
                        Text(
                          '$categoryName',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height / 40),
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.date_range_rounded,
                              color: ColorManager.primary,
                            ),
                            Text(tasksList[index].dueDate),
                          ],
                        ),

                        // Switch(value: false, onChanged: (value) {}),

                        Spacer(),
                        tasksList[index].remindMe == true
                            ? Row(children: [
                                Icon(
                                  Icons.timer_outlined,
                                  color: ColorManager.primary,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(tasksList[index].reminderTime),
                                Icon(
                                  Icons.date_range_rounded,
                                  color: ColorManager.primary,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(tasksList[index].reminderDate),
                              ])
                            : Container(),
                      ],
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
