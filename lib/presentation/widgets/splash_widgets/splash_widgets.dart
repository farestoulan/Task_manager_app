import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:task_manager_app/core/utils/assets_manager/asstets_manager.dart';

import '../../screens/home/home_screen.dart';

class SplashWedget extends StatelessWidget {
  final int todayTimeStamp =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .toUtc()
          .millisecondsSinceEpoch;
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splashIconSize: 500,
        backgroundColor: Colors.white,
        splashTransition: SplashTransition.scaleTransition,
        pageTransitionType: PageTransitionType.rightToLeft,
        splash: ImageAssete.splashScreenIcone,
        nextScreen: HomeScreen(),

// we can use
        duration: 3000,
//3000= 3 Second

//control the duration of the image , we can use
        animationDuration: const Duration(seconds: 2));
//small number : the duration will be speed
//large number : the duratiion will be slow);
  }
}
