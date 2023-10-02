import 'package:flutter/material.dart';

import '../../../core/reusable_component/txt_field_component.dart';

class AddCategoriesScreen extends StatelessWidget {
  TextEditingController categoryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Categories',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
        ),
        body: Column(
          children: [
            CustomTxtField(
              controller: categoryController,
              emptyErrMsg: 'bbbbb',
              txtInputType: TextInputType.text,
            )
          ],
        ));
  }
}
