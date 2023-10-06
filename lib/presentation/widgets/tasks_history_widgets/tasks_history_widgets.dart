import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/app_strings/app_strings.dart';
import '../../../core/reusable_component/txt_field_component.dart';
import '../../../core/utils/assets_manager/asstets_manager.dart';
import '../../../core/utils/styles/color/color_manger.dart';
import '../../../core/utils/styles/fonts/font_maneger.dart';
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
    required Function onTapItem,
    required String categoryName,
  }) {
    return InkWell(
      onTap: () {
        onTapItem();
      },
      child: Padding(
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
                Container(
                  width: width / 4,
                  child: SlidableAction(
                    borderRadius: BorderRadius.circular(20),
                    onPressed: (context) {
                      onTapDelet();
                    },
                    backgroundColor: ColorManager.redColor,
                    foregroundColor: ColorManager.whiteColor,
                    icon: Icons.delete,
                    label: AppStrings.deleteLabel,
                  ),
                ),
                Container()
                // SizedBox(
                //   width: width / 30,
                // ),
                // SlidableAction(
                //   borderRadius: BorderRadius.circular(20),
                //   onPressed: (context) {
                //     onTapEdit();
                //   },
                //   backgroundColor: ColorManager.grey1,
                //   foregroundColor: ColorManager.whiteColor,
                //   icon: Icons.edit,
                //   label: AppStrings.editLabel,
                // ),
              ]),
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
                      children: [
                        Expanded(
                          child: Image.asset(
                            ImageAssete.TaskItemIcon,
                            width: 1,
                            height: 50,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          tasksList[index].taskTitle,
                          style: getSemiBoldStyle(
                              color: ColorManager.blackColor,
                              fontFamily: AppStrings.gilroySemiBold),
                        ),
                        Spacer(),
                        Container(
                            height: height / 30,
                            width: width / 5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: ColorManager.lightGreen2),
                            child: Center(
                                child: Text(
                              '${tasksList[index].isCompleted == true ? 'Completed' : 'New'}',
                              style: getRegularStyle(
                                  color: ColorManager.primary,
                                  fontFamily: AppStrings.gilroyRegular),
                            ))),
                      ],
                    ),
                    SizedBox(height: height / 50),
                    Padding(
                      padding: const EdgeInsets.only(left: 100),
                      child: Row(
                        children: [
                          Text(
                            '$categoryName',
                            style: getRegularStyle(
                                color: ColorManager.blackColor,
                                fontFamily: AppStrings.gilroyRegular),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height / 40),
                    tasksList[index].remindMe == true
                        ? Padding(
                            padding: const EdgeInsets.only(left: 50),
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.timer_outlined,
                                  color: ColorManager.primary,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(tasksList[index].reminderTime),
                                Spacer(),
                                Icon(
                                  Icons.date_range_rounded,
                                  color: ColorManager.primary,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(tasksList[index].reminderDate),
                              ],
                            ),
                          )
                        : Container(),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  static Widget desginAddCategoies({
    required double width,
    required double height,
    required TextEditingController categoryController,
    required Function onTapAddNew,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: width / 2.2,
            child: CustomTxtField(
              isDimed: false,
              //isEnabled: ,
              togglePassword: () {},
              hintText: AppStrings.hintTyping,
              labelText: AppStrings.addCategoiesLabel,
              controller: categoryController,
              emptyErrMsg: 'bbbbb',
              txtInputType: TextInputType.text,
            ),
          ),
          InkWell(
            onTap: () {
              onTapAddNew();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: ColorManager.lightGreen,
                  borderRadius: BorderRadius.circular(15)),
              height: height / 15,
              width: width / 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ColorManager.lightGreen2,
                    ),
                    height: 40,
                    width: 40,
                    child: Icon(
                      Icons.add,
                      color: ColorManager.green,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    AppStrings.addNewLabel,
                    style: getMediumStyle(
                      fontFamily: AppStrings.gilroyMedium,
                      color: ColorManager.green,
                      fontSize: FontSize.s16,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
