import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../core/app_strings/app_strings.dart';
import '../../../core/utils/styles/color/color_manger.dart';
import '../../../core/utils/styles/fonts/font_maneger.dart';
import '../../../core/utils/styles/fonts/style_fonts.dart';

class AppTheme {
  //
  AppTheme._();
//=================================== Light Theme Mode

  static final ThemeData lightTheme = ThemeData(
    iconTheme: IconThemeData(
      color: ColorManager.blackColor,
    ),
    // iconButtonTheme: IconButtonTheme.of(context).style.iconColor.resolve(states)
    // IconButtonThemeData(
    //     style: ButtonStyle(
    //         iconColor: MaterialStateColor.resolveWith(
    //             (states) => ColorManager.primary))),
    //toggleButtonsTheme: ToggleButtonsThemeData(color: ColorManager.primary),
    scaffoldBackgroundColor: ColorManager.whiteColor,
    appBarTheme: AppBarTheme(
        color: ColorManager.primary,
        iconTheme: IconThemeData(
          color: ColorManager.blackColor,
        ),
        titleTextStyle: getMediumStyle(
            color: ColorManager.blackColor,
            fontFamily: AppStrings.gilroyMedium,
            fontSize: FontSize.s18)),
    // colorScheme: const ColorScheme.light(
    //   primary: Colors.black,
    //   onPrimary: Colors.black,
    //   secondary: Colors.red,
    // ),
    // cardTheme: const CardTheme(
    //   color: Colors.black,
    // ),
    // iconTheme: IconThemeData(
    //   color: Colors.white54,
    // ),
    textTheme: TextTheme(
        titleMedium: getRegularStyle(
      color: Colors.white,
      fontFamily: AppStrings.gilroyRegular,
    )),
  );
//=================================== dark Theme Mode
  static final ThemeData darkTheme = ThemeData(
    iconTheme: IconThemeData(
      color: ColorManager.blackColor,
    ),
    // iconButtonTheme: IconButtonThemeData(
    //     style: ButtonStyle(
    //         iconColor: MaterialStateColor.resolveWith(
    //             (states) => ColorManager.blackColor))),
    // toggleButtonsTheme: ToggleButtonsThemeData(color: ColorManager.blackColor),
    scaffoldBackgroundColor: HexColor('333739'),
    appBarTheme: AppBarTheme(
        color: HexColor('333739'),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        titleTextStyle: getMediumStyle(
            color: Colors.white,
            fontFamily: AppStrings.gilroyMedium,
            fontSize: FontSize.s18)),
    // colorScheme: const ColorScheme.light(
    //   primary: Colors.black,
    //   onPrimary: Colors.black,
    //   secondary: Colors.red,
    // ),
    // cardTheme: const CardTheme(
    //   color: Colors.black,
    // ),
    // iconTheme: IconThemeData(
    //   color: Colors.white54,
    // ),
    textTheme: TextTheme(
        titleMedium: getRegularStyle(
      color: Colors.white,
      fontFamily: AppStrings.gilroyRegular,
    )),
  );
}
