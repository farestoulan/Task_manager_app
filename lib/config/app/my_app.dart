import 'package:flutter/material.dart';
import 'package:task_manager_app/config/app/routes/app_routes.dart';
import 'package:task_manager_app/config/app/themes/app_thems.dart';
import '../../core/notification_service/notification_service.dart';

class MyApp extends StatefulWidget {
  final bool isDark;
  MyApp(this.isDark);

  // The navigator key is necessary to navigate using static methods
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static bool isDarkMode = false;

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,

      themeMode: ThemeMode.light,

      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
