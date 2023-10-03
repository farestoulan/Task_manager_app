import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/config/app/routes/app_routes.dart';
import 'package:task_manager_app/config/app/themes/app_thems.dart';
import '../../business_logic/app_cubit/app_cubit.dart';
import '../../business_logic/app_cubit/app_cubit_state.dart';

class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp(this.isDark);

  static bool isDarkMode = false;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..changeAppMode(isDarkFromShared: isDark),
      child: BlocConsumer<AppCubit, AppCubitState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            // title: 'Flutter Demo',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,

            themeMode: ThemeMode.light,
            // AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            onGenerateRoute: AppRoutes.onGenerateRoute,
          );
        },
      ),
    );
  }
}
