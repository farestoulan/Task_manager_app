import 'package:flutter/material.dart';
import '../../widgets/splash_widgets/splash_widgets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashWedget(),
    );
  }
}
