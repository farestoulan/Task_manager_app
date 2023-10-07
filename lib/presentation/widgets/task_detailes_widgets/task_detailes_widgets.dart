import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:task_manager_app/core/utils/styles/fonts/font_maneger.dart';

import '../../../core/app_strings/app_strings.dart';
import '../../../core/utils/styles/color/color_manger.dart';
import '../../../core/utils/styles/fonts/style_fonts.dart';

class TaskDetailesWidgets {
  static Widget buildBackButton({
    required double width,
    required Function onTapBackButton,
  }) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        width: width / 2.3,
        decoration: BoxDecoration(
          border: Border.all(color: ColorManager.primary),
        ),
        child: TextButton(
          onPressed: () {
            onTapBackButton();
          },
          child: Text(
            'Back Home',
            style: TextStyle(
              color: ColorManager.primary,
              fontWeight: FontWeight.bold,
              fontSize: FontSize.s20,
            ),
          ),
        ),
      ),
    );
  }

//============================== Edit And Delet
  static Widget buildRowEditAndDelet({
    required Function onTapEdit,
    required Function onTapDelet,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Spacer(),
              InkWell(
                onTap: () {
                  onTapEdit();
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.edit,
                      color: ColorManager.lightGreen3,
                      size: 30,
                    ),
                    Text(
                      AppStrings.editBTNLabel,
                      style: getRegularStyle(
                          fontFamily: AppStrings.gilroyRegular,
                          color: ColorManager.editIcongrey,
                          fontSize: FontSize.s12),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  onTapDelet();
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.delete_rounded,
                      color: ColorManager.redColor,
                      size: 30,
                    ),
                    Text(
                      AppStrings.deletBTNLabel,
                      style: getRegularStyle(
                        fontFamily: AppStrings.gilroyRegular,
                        color: ColorManager.redColor,
                        fontSize: FontSize.s12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

//========================= BTN Save Task Befor Editing
  static Widget buildBTNSaveTask({
    required double height,
    required double width,
    required Function editTask,
  }) {
    return InkWell(
      onTap: () {
        editTask();
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
                fontSize: FontSize.s20,
              ),
            )
          ],
        ),
      ),
    );
  }

//====================== Check box Reminder
  static Widget buildChechRemindMe({
    required double width,
    required bool isChecked,
    required Function(bool? checkedValue) onTapChecked,
    required bool isEditable,
  }) {
    return Row(
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
          onTap: isEditable == true
              ? (value) async {
                  onTapChecked(value);
                }
              : (value) {},
        ),
      ],
    );
  }

//====================== Change Status
  static Widget buildChangeStatus({
    required double width,
    required bool isChecked,
    required Function(bool? checkedValue) onTapChecked,
    required bool isEditable,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${AppStrings.changeStatusLabel}',
          style: getMediumStyle(
              color: ColorManager.blackColor,
              fontFamily: AppStrings.gilroyMedium),
        ),
        Transform.scale(
          scale: 1.5,
          child: Switch(
            activeTrackColor: ColorManager.primary,
            activeColor: ColorManager.whiteColor,
            value: isChecked,
            onChanged: isEditable == true
                ? (valueChanged) {
                    onTapChecked(valueChanged);
                  }
                : (value) {},
          ),
        ),
      ],
    );
  }
}
