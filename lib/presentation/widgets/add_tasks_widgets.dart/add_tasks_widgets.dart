import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import '../../../core/app_strings/app_strings.dart';
import '../../../core/reusable_component/date_picker.dart';
import '../../../core/reusable_component/drop_down_list_componenet.dart';
import '../../../core/reusable_component/txt_field_component.dart';
import '../../../core/utils/styles/color/color_manger.dart';
import '../../../core/utils/styles/fonts/font_maneger.dart';
import '../../../core/utils/styles/fonts/style_fonts.dart';

class AddTasksWidgets {
  static Widget buildAddTaskBody({
    required double height,
    required double width,
    required TextEditingController addTaskTitleController,
    required context,
    required TextEditingController dateController,
    required bool? isChecked,
    required Function(bool? selectValue) onTapChecked,
    required Function(String selectValue) onChangeDropDownCategory,
    required String? categoryDropDown,
    required List<String> itemsDropDownList,
    required Function onTapAddNew,
    required Function onTapReminderDateAndTime,
    required bool? isReminder,
    required Function(String selectValue) onChangeTaskTitleTextFeild,
  }) {
    return SizedBox(
      height: height / 1.5,
      width: double.infinity,
      child: Card(
        shadowColor: ColorManager.shadowColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
//========================= Text Feild Add Task
              CustomTxtField(
                onchange: (value) {
                  onChangeTaskTitleTextFeild(value!);
                },
                isDimed: false,
                //isEnabled: ,
                togglePassword: () {},
                hintText: AppStrings.hintTypingTask,
                labelText: AppStrings.addTasksLabel,
                controller: addTaskTitleController,
                emptyErrMsg: AppStrings.taskTitleRequiredMsg,
                txtInputType: TextInputType.text,
              ),
              SizedBox(
                height: height / 25,
              ),
//========================== Text Feild Dueo Date
              DatePicker.buildDatePicker(
                context: context,
                hintText: AppStrings.addDueDate,
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
                      var formatter = new DateFormat('yyyy-MM-dd', 'en');
                      String formattedDate = formatter.format(value!);
                      dateController.text = formattedDate;
                    },
                  );
                },
                dateController: dateController,
              ),
              SizedBox(
                height: height / 25,
              ),

//====================== Check box Reminder
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${AppStrings.reminderMe}',
                    style: getMediumStyle(
                        color: ColorManager.blackColor,
                        fontFamily: AppStrings.gilroyMedium),
                  ),
                  RoundCheckBox(
                    isRound: false,
                    size: width / 15,
                    isChecked: isChecked,
                    borderColor: ColorManager.primary,
                    checkedColor: ColorManager.primary,
                    checkedWidget: Center(
                      child: Icon(
                        Icons.check,
                        color: ColorManager.whiteColor,
                        size: width / 24,
                      ),
                    ),
                    onTap: (value) async {
                      onTapChecked(value);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: height / 70,
              ),
//====================== Show Reminder Date And Time
              isReminder == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Reminder Date & Time'),
                        IconButton(
                          onPressed: () {
                            onTapReminderDateAndTime();
                          },
                          icon: Icon(
                            Icons.date_range_outlined,
                            color: ColorManager.primary,
                            size: 25,
                          ),
                        ),
                      ],
                    )
                  : Container(),

              SizedBox(
                height: height / 25,
              ),
//========================== Drop Down Categories
              Flexible(
                child: DropDownComponenet(
                  hint: 'Select Category',
                  onChange: (value) {
                    onChangeDropDownCategory(value);
                  },
                  itemsDropDownList: itemsDropDownList,
                  selectedValue: categoryDropDown,
                ),
              ),
              Spacer(),
//========================= BTN Add new
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
                          Icons.save,
                          color: ColorManager.green,
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        AppStrings.saveLabel,
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
        ),
      ),
    );
  }
}
