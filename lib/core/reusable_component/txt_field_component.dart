import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_strings/app_strings.dart';
import '../utils/styles/color/color_manger.dart';
import '../utils/styles/fonts/font_maneger.dart';
import '../utils/styles/fonts/style_fonts.dart';

class CustomTxtField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureTxt;
  final bool isPasswordFeild;
  final String emptyErrMsg;
  final Function togglePassword;
  final int maxmimLength;
  final int? maxLiness;
  final String hintText;
  final String labelText;

  final TextInputType txtInputType;
  final String? Function(String? value)? validator;
  final bool isEnabled;
  final bool isDimed;
  Function(String? value)? onchange;

  CustomTxtField({
    required this.controller,
    required this.togglePassword,
    required this.emptyErrMsg,
    required this.txtInputType,
    required this.isDimed,
    required this.hintText,
    required this.labelText,
    this.isPasswordFeild = false,
    this.obscureTxt = false,
    this.isEnabled = true,
    this.validator,
    this.maxmimLength = 2000,
    this.maxLiness,
    this.onchange,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        if (onchange != null) {
          onchange!(value);
        }
      },
      style: getRegularStyle(
        fontFamily: AppStrings.gilroySemiBold,
        color: ColorManager.blackColor,
        fontSize: FontSize.s16,
      ),
      maxLines: maxLiness,
      //   autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscureTxt,
      controller: controller,
      keyboardType: txtInputType,
      decoration: InputDecoration(
        // errorBorder: InputBorder.none,
        // errorStyle: TextStyle(height: 0),
        // errorText: 'bc',
        hintText: hintText,
        labelText: labelText,
        isDense: true,
        filled: true,
        fillColor: isDimed == true ? ColorManager.dimedBg : ColorManager.grey2,
        suffixIcon: Visibility(
          visible: isPasswordFeild,
          child: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () => togglePassword(),
            icon: Icon(
                obscureTxt == true
                    ? Icons.visibility_off
                    : Icons.remove_red_eye,
                size: 25,
                color: ColorManager.grey1),
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
        enabled: isEnabled,
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxmimLength),
      ],
      validator: (val) {
        if (validator != null) {
          return validator!(val);
        } else if (val!.isEmpty) {
          return emptyErrMsg;
        }

        return null;
      },
    );
  }
}

// class CustomTxtField extends StatelessWidget {
//   final TextEditingController controller;
//   final String emptyErrMsg;
//   final int maxmimLength;
//   final int? maxLiness;
//   final TextInputType txtInputType;
//   final String? Function(String? value)? validator;
//   final bool isEnabled;
//   Function(String? value)? onchange;
//   final String hintText;
//   final String labelText;

//   CustomTxtField({
//     required this.controller,
//     required this.emptyErrMsg,
//     required this.txtInputType,
//     required this.hintText,
//     required this.labelText,
//     this.isEnabled = true,
//     this.validator,
//     this.maxmimLength = 2000,
//     this.maxLiness,
//     this.onchange,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       onChanged: (value) {
//         if (onchange != null) {
//           onchange!(value);
//         }
//       },
//       style: getRegularStyle(
//         fontFamily: AppStrings.gilroySemiBold,
//         color: ColorManager.blackColor,
//         fontSize: FontSize.s17,
//       ),
//       maxLines: maxLiness,
//       //   autovalidateMode: AutovalidateMode.onUserInteraction,
//       controller: controller,
//       keyboardType: txtInputType,
//       decoration: InputDecoration(
//         // icon: Icon(Icons.category_outlined),
//         hintText: hintText,
//         labelText: labelText,
//         isDense: true,
//         filled: true,
//         fillColor: ColorManager.grey2,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0),
//           borderSide: BorderSide(
//             color: ColorManager.grey3,
//           ),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0),
//           borderSide: BorderSide(
//             color: ColorManager.grey3,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0),
//           borderSide: BorderSide(
//             color: ColorManager.grey3,
//           ),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0),
//           borderSide: BorderSide(
//             color: ColorManager.grey3,
//             width: 2.0,
//           ),
//         ),
//         enabled: isEnabled,
//       ),
//       inputFormatters: [
//         LengthLimitingTextInputFormatter(maxmimLength),
//       ],
//       validator: (val) {
//         if (validator != null) {
//           return validator!(val);
//         } else if (val!.isEmpty) {
//           return emptyErrMsg;
//         }

//         return null;
//       },
//     );
//   }
// }
