import 'package:flutter/material.dart';

import '../app_strings/app_strings.dart';
import '../utils/styles/color/color_manger.dart';
import '../utils/styles/fonts/font_maneger.dart';
import '../utils/styles/fonts/style_fonts.dart';

class DatePicker {
  static Widget buildDatePicker({
    required Function togglePassword,
    required TextEditingController dateController,
    required String hintText,
    final String? Function(String? value)? validator,
    bool isEditable = true,
  }) {
    return TextFormField(
      style: getRegularStyle(
        fontFamily: AppStrings.gilroySemiBold,
        color: ColorManager.blackColor,
        fontSize: FontSize.s17,
      ),
      //   autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: dateController,
      keyboardType: TextInputType.none,
      decoration: InputDecoration(
        enabled: isEditable,
        hintText: hintText,
        labelText: hintText,

        filled: true,
        fillColor: ColorManager.grey2,
        // hintStyle: TextStyle(color: ColorManager.primary, fontSize: 15),
        suffixIcon: Visibility(
          visible: true,
          child: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: isEditable ? () => togglePassword() : () {},
            icon: isEditable
                ? Icon(
                    color: ColorManager.primary,
                    Icons.calendar_month_rounded,
                    size: 25,
                  )
                : Container(),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: ColorManager.grey3,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: ColorManager.grey3,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: ColorManager.grey3,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: ColorManager.grey3,
            width: 2.0,
          ),
        ),
      ),
      validator: (val) {
        if (validator != null) {
          return validator(val);
        } else if (val!.isEmpty) {
          return 'test';
        }

        return null;
      },
    );
  }
}
