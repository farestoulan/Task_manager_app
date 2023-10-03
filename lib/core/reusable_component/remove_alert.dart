import 'package:flutter/material.dart';
import '../app_strings/app_strings.dart';
import '../utils/styles/color/color_manger.dart';
import '../utils/styles/fonts/font_maneger.dart';
import '../utils/styles/fonts/style_fonts.dart';

removeAlert(
    {required BuildContext ctx,
    required double height,
    required double width,
    required String content,
    required Function doneFunction}) {
  showDialog(
    barrierDismissible: true,
    context: ctx,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        content: SizedBox(
          width: MediaQuery.of(context).size.width / 1,
          height: MediaQuery.of(context).size.height / 10,
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
                      fontFamily: AppStrings.gilroyMedium,
                      color: ColorManager.blackColor,
                      fontSize: FontSize.s17),
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorManager.green,
                  ),
                  child: TextButton(
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                        color: ColorManager.whiteColor,
                      ),
                    ),
                    onPressed: () {
                      doneFunction();
                    },
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 3.5,
                  decoration: BoxDecoration(
                    color: ColorManager.redColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    child: Text(
                      'No',
                      style: TextStyle(
                        color: ColorManager.whiteColor,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      );
    },
  );
}
