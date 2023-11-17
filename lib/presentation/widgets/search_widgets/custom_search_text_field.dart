import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/app_strings/app_strings.dart';
import '../../../core/utils/styles/color/color_manger.dart';
import '../../../core/utils/styles/fonts/font_maneger.dart';
import '../../../core/utils/styles/fonts/style_fonts.dart';

class CustomSearchTextField extends StatelessWidget {
  Function(String? value)? onchange;
  TextEditingController textEditingController;

  CustomSearchTextField(
      {super.key, required this.onchange, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: getRegularStyle(
        fontFamily: AppStrings.gilroySemiBold,
        color: ColorManager.blackColor,
        fontSize: FontSize.s16,
      ),
      controller: textEditingController,
      onChanged: (value) {
        if (onchange != null) {
          onchange!(value);
        }
      },
      decoration: InputDecoration(
        enabledBorder: buildOutlineInputBorder(),
        focusedBorder: buildOutlineInputBorder(),
        hintText: 'Search',
        suffixIcon: IconButton(
          onPressed: () {},
          icon: const Opacity(
            opacity: .8,
            child: Icon(
              FontAwesomeIcons.magnifyingGlass,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.white,
      ),
      borderRadius: BorderRadius.circular(
        12,
      ),
    );
  }
}
