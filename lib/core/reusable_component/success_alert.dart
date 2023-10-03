import 'package:flutter/material.dart';
import '../app_strings/app_strings.dart';
import '../utils/styles/color/color_manger.dart';
import '../utils/styles/fonts/style_fonts.dart';

successAlert({
  required BuildContext ctx,
  required double width,
  required String content,
}) {
  showDialog(
    context: ctx,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        title: Center(
          child: Icon(
            Icons.check_circle,
            size: 40,
            color: ColorManager.green,
          ),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width / 1,
          height: MediaQuery.of(context).size.height / 15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  content,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: getBoldStyle(
                      color: ColorManager.blackColor,
                      fontSize: width / 26,
                      fontFamily: AppStrings.gilroyMedium),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
