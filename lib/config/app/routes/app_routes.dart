import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:task_manager_app/presentation/screens/home/home_screen.dart';
import 'package:task_manager_app/presentation/screens/tasks_history_screen/tasks_history_screen.dart';

class Routes {
  static const String initialRoute = '/';

  static const String tasksHistoryScreen = '/tasksHistoryScreen';

  static const String tasksHomeScreen = '/tasksHomeScreen';

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
          child: HomeScreen(),
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

//======================= Tasks History Screen
      case Routes.tasksHomeScreen:
        return PageTransition(
          child: HomeScreen(),
          type: PageTransitionType.leftToRight,
          settings: routeSettings,
        );

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: ((context) => const Scaffold(
              body: Center(
                child: Text('noRouteFound'),
              ),
            )));
  }
}
