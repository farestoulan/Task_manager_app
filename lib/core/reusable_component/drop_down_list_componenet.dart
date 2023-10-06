import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../app_strings/app_strings.dart';
import '../utils/styles/color/color_manger.dart';
import '../utils/styles/fonts/style_fonts.dart';

class DropDownComponenet extends StatefulWidget {
  final List<String> itemsDropDownList;

  final String? selectedValue;
  final Function onChange;
  final String? hint;

  DropDownComponenet(
      {Key? key,
      required this.itemsDropDownList,
      required this.selectedValue,
      required this.onChange,
      this.hint})
      : super(key: key);

  @override
  State<DropDownComponenet> createState() => _DropDownComponenetState();
}

class _DropDownComponenetState extends State<DropDownComponenet> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          widget.hint ?? '',
          style: getRegularStyle(
              fontFamily: AppStrings.gilroyRegular,
              color: ColorManager.blackColor),
        ),
        isExpanded: true,
        items: widget.itemsDropDownList
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: getMediumStyle(
                        color: ColorManager.blackColor,
                        fontFamily: AppStrings.gilroyRegular),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        value: widget.selectedValue,
        onChanged: (value) {
          widget.onChange(value);
        },
        buttonStyleData: ButtonStyleData(
          height: 60,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: ColorManager.grey2,
            ),
            color: ColorManager.grey2,
          ),
          elevation: 0,
        ),
        iconStyleData: IconStyleData(
          icon: Icon(
            Icons.keyboard_arrow_down,
            size: 30,
          ),
          iconSize: 14,
          iconEnabledColor: ColorManager.blackColor,
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorManager.grey2,
          ),
          elevation: 8,
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all<double>(6),
            thumbVisibility: MaterialStateProperty.all<bool>(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(),
      ),
    );
  }
}
