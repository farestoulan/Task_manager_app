import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/business_logic/tasks_history_cubit/tasks_history_cubit.dart';
import 'package:task_manager_app/business_logic/tasks_history_cubit/tasks_history_state.dart';
import '../../../business_logic/app_cubit/app_cubit.dart';
import '../../../business_logic/app_cubit/app_cubit_state.dart';
import '../../widgets/home_widgets/home_bottom_nav_widgets.dart';
import '../add_categories_screen/categories_manager_screen.dart';
import '../create_task_screen/create_task_screen.dart';
import '../task_details_screen/task_details_screen.dart';
import '../tasks_history_screen/tasks_history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppCubitState>(
      listener: (context, state) {},
      builder: (context, state) {
        var selectIndex = AppCubit.get(context).currentIndex;
        return Scaffold(
            bottomNavigationBar: HomeBottomNavigationWidget(
              isDark: AppCubit.get(context).isDark,
              selectIndex: selectIndex,
              onTabChange: (selectIndex) {
                AppCubit.get(context).changeIndex(selectIndex);
                _page = selectIndex;
              },
            ),
            body: _page == 0
                ? TasksHistoryScreen()
                : _page == 1
                    ? CreateTaskScreen()
                    : _page == 2
                        ? AddCategoriesScreen()
                        : Container());
      },
    );
  }
}
