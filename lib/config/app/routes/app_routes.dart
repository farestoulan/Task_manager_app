import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:task_manager_app/data/models/taskes_model/tasks_model.dart';
import 'package:task_manager_app/presentation/screens/home/home_screen.dart';
import 'package:task_manager_app/presentation/screens/tasks_history_screen/tasks_history_screen.dart';

import '../../../presentation/screens/search_screen/search_screen.dart';
import '../../../presentation/screens/splash_screen/splash_screen.dart';
import '../../../presentation/screens/task_details_screen/task_details_screen.dart';

class Routes {
  static const String initialRoute = '/';

  static const String tasksHistoryScreen = '/tasksHistoryScreen';

  static const String tasksHomeScreen = '/tasksHomeScreen';

  static const String tasksDetailesScreen = '/tasksDetailesScreen';

  static const String ditTasksDetailesScreen = '/ditTasksDetailesScreen';

  static const String searchScreen = '/searchScreen';

//================================== navigate and Push
  static void navigateTo(context, String namedRouting) => Navigator.pushNamed(
        context,
        namedRouting,
      );
//================================= navigate and finsh

  static navigateAndFinish(context, String namedRouting) =>
      Navigator.pushNamedAndRemoveUntil(
          context, namedRouting, (Route<dynamic> route) => false);

//==================== navigate and finsh passing Args

  static void navigateAndFinishArgs(context, String namedRouting, Args) =>
      Navigator.pushNamedAndRemoveUntil(
          context, namedRouting, (Route<dynamic> route) => false,
          arguments: Args);

//==================== navigate and Push passing Args

  static void navigateAndPushArgs(context, String namedRouting, Args) =>
      Navigator.pushNamed(context, namedRouting, arguments: Args);

//==================== navigate and Push passing Args

  static void navigateAndPushReplacmentArgs(
          context, String namedRouting, Args) =>
      Navigator.pushReplacementNamed(context, namedRouting, arguments: Args);

//==================== navigate and Push passing Args

  static void navigateAndPushReplacment(context, String namedRouting) =>
      Navigator.pushReplacementNamed(context, namedRouting);
}

//==============================================================================
class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
//======================= inital Screen
      case Routes.initialRoute:
        return PageTransition(
          child: SplashScreen(),
          type: PageTransitionType.leftToRight,
          settings: routeSettings,
        );

//======================= Tasks History Screen
      case Routes.tasksHistoryScreen:
        return PageTransition(
          child: TasksHistoryScreen(),
          type: PageTransitionType.leftToRight,
          settings: routeSettings,
        );

//======================= Home Screen
      case Routes.tasksHomeScreen:
        return PageTransition(
          child: HomeScreen(),
          type: PageTransitionType.leftToRight,
          settings: routeSettings,
        );

//======================= Tasks Detailes Screen

      case Routes.tasksDetailesScreen:
        return PageTransition(
          child: routeSettings.arguments is TasksModel
              ? TaskDetailsScreen(
                  tasksModel: routeSettings.arguments as TasksModel,
                )
              : TaskDetailsScreen(),
          type: PageTransitionType.leftToRight,
          settings: routeSettings,
        );

//======================= Edit Task Screen in history screen

      case Routes.ditTasksDetailesScreen:
        return PageTransition(
          child: routeSettings.arguments is TasksModel
              ? TaskDetailsScreen(
                  tasksModel: routeSettings.arguments as TasksModel,
                  isEditabel: false,
                )
              : TaskDetailsScreen(),
          type: PageTransitionType.leftToRight,
          settings: routeSettings,
        );

//======================= Search Screen
      case Routes.searchScreen:
        return PageTransition(
          child: SearchView(),
          type: PageTransitionType.leftToRight,
          settings: routeSettings,
        );

      default:
        return undefinedRoute();
    }
  }

//================================== No Route Found
  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: ((context) => const Scaffold(
              body: Center(
                child: Text('noRouteFound'),
              ),
            )));
  }
}
