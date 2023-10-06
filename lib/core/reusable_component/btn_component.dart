// ignore_for_file: import_of_legacy_library_into_null_safe, deprecated_member_use

import 'package:flutter/material.dart';
import '../app_strings/app_strings.dart';
import '../utils/styles/color/color_manger.dart';
import '../utils/styles/fonts/style_fonts.dart';

class CustomBtn extends StatelessWidget {
  final double height;
  final double width;
  final String btnTxt;
  final Function btnOnpressedFun;
  final bool isFilledBg;
  final Color bgColor;
  const CustomBtn(
      {required this.height,
      required this.btnTxt,
      required this.btnOnpressedFun,
      this.width = double.infinity,
      this.isFilledBg = true,
      required this.bgColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: bgColor,
      ),
      width: width,
      height: height / 15,
      child: MaterialButton(
        onPressed: () => btnOnpressedFun(),
        child: Text(
          btnTxt,
          style: getSemiBoldStyle(
            fontFamily: AppStrings.gilroySemiBold,
            color: ColorManager.whiteColor,
          ),
        ),
      ),
    );
  }
}
