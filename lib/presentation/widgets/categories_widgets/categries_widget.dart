import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../core/app_strings/app_strings.dart';
import '../../../core/reusable_component/txt_field_component.dart';
import '../../../core/utils/styles/color/color_manger.dart';
import '../../../core/utils/styles/fonts/font_maneger.dart';
import '../../../core/utils/styles/fonts/style_fonts.dart';
import '../../../data/models/categories_model/categories_model.dart';

class CategoriesWidgets {
  static Widget desginAddCategoies({
    required double width,
    required double height,
    required TextEditingController categoryController,
    required Function onTapAddNew,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: width / 2.2,
            child: CustomTxtField(
              isDimed: false,
              //isEnabled: ,
              togglePassword: () {},
              hintText: AppStrings.hintTyping,
              labelText: AppStrings.addCategoiesLabel,
              controller: categoryController,
              emptyErrMsg: 'bbbbb',
              txtInputType: TextInputType.text,
            ),
          ),
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
                      Icons.add,
                      color: ColorManager.green,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    AppStrings.addNewLabel,
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
    );
  }

//==============================================================================
  static Widget buildItemInListCategories({
    required double height,
    required double width,
    required List<CategoriesModel> categoriesList,
    required int index,
    required Function onTapDelet,
    required Function onTapEdit,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
        width: double.infinity,
        height: height / 8,
        child: Slidable(
          // Specify a key if the Slidable is dismissible.
          key: const ValueKey(0),

          // The start action pane is the one at the left or the top side.
          startActionPane: ActionPane(
              // A motion is a widget used to control how the pane animates.
              motion: const ScrollMotion(),

              // A pane can dismiss the Slidable.
              //***** */ dismissible: DismissiblePane(onDismissed: () {}),

              // All actions are defined in the children parameter.
              children: [
                // A SlidableAction can have an icon and/or a label.
                SlidableAction(
                  borderRadius: BorderRadius.circular(20),
                  onPressed: (context) {
                    onTapDelet();
                  },
                  backgroundColor: ColorManager.redColor,
                  foregroundColor: ColorManager.whiteColor,
                  icon: Icons.delete,
                  label: AppStrings.deleteLabel,
                ),
                SizedBox(
                  width: width / 30,
                ),
                SlidableAction(
                  borderRadius: BorderRadius.circular(20),
                  onPressed: (context) {
                    onTapEdit();
                  },
                  backgroundColor: ColorManager.grey1,
                  foregroundColor: ColorManager.whiteColor,
                  icon: Icons.edit,
                  label: AppStrings.editLabel,
                ),
              ]),
          child: Card(
            shadowColor: ColorManager.shadowColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            elevation: 5.0,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.categoryName,
                          style: getSemiBoldStyle(
                              color: ColorManager.blackColor,
                              fontFamily: AppStrings.gilroySemiBold),
                        ),
                        Text(categoriesList[index].categoryName),
                      ],
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }

//==============================================================================
  static buildEditAlert({
    required BuildContext ctx,
    required double height,
    required double width,
    required Function doneFunction,
    required TextEditingController editController,
    required categoryValue,
  }) {
    editController.text = categoryValue;
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
            child: CustomTxtField(
              isDimed: false,
              //isEnabled: ,
              togglePassword: () {},
              hintText: AppStrings.hintTyping,
              labelText: AppStrings.addCategoiesLabel,
              controller: editController,
              emptyErrMsg: 'tesssst',
              txtInputType: TextInputType.text,
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
                        AppStrings.editLabel,
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
                        AppStrings.cancelLabel,
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
}
