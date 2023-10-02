import 'package:flutter/material.dart';

class CreateTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Task',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Center(child: Text('Create Task')),
    );
  }
}
