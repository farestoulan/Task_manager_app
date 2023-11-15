import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/business_logic/app_cubit/app_cubit.dart';
import 'package:task_manager_app/business_logic/app_cubit/app_cubit_state.dart';
import 'package:task_manager_app/business_logic/tasks_history_cubit/tasks_history_cubit.dart';
import 'package:task_manager_app/business_logic/tasks_history_cubit/tasks_history_state.dart';
import 'package:task_manager_app/config/app/routes/app_routes.dart';
import 'package:task_manager_app/config/app/themes/app_thems.dart';
import '../../core/notification_service/notification_service.dart';
import 'package:task_manager_app/injection_container.dart' as di;

class MyApp extends StatefulWidget {
  final bool isDark;
  MyApp(this.isDark);

  // The navigator key is necessary to navigate using static methods
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  // bool isDarkMode = isDark;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    NotificationController.startListeningNotificationEvents();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
              di.sl<AppCubit>()..changeAppMode(isDarkFromShared: widget.isDark),
        ),
      ],
      child: BlocConsumer<AppCubit, AppCubitState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          print('is Dark: *******${AppCubit.get(context).isDark}');
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            // title: 'Flutter Demo',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,

            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,

            //  ThemeMode.light,

            onGenerateRoute: AppRoutes.onGenerateRoute,
          );
        },
      ),
    );
  }
}
