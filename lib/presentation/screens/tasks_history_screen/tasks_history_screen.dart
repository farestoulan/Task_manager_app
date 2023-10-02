import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/business_logic/cubit/app_cubit.dart';
import 'package:task_manager_app/config/app/my_app.dart';

class TasksHistoryScreen extends StatefulWidget {
  @override
  State<TasksHistoryScreen> createState() => _TasksHistoryScreenState();
}

class _TasksHistoryScreenState extends State<TasksHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppCubitState>(
        listener: (context, state) {
          if (state is AppChangeModeState) {
            MyApp.isDarkMode = true;
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Tasks History',
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                // IconButton(
                //     onPressed: () {
                //       AppCubit.get(context).changeAppMode();
                //     },
                //     icon: const Icon(Icons.brightness_4_outlined))
              ],
            ),
            body: Center(
                child: Text(
              'Tasks History',
              style: Theme.of(context).textTheme.titleMedium,
            )),
          );
        },
      ),
    );
  }
}
