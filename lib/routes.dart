import 'package:flutter/material.dart';

import 'src/screens/home_screen.dart';
import 'src/screens/onboarding_screen.dart';
import 'src/screens/splash_screen.dart';

class AppRoutes {
  static const String initialScreen = '/';
  static const String mainScreen = '/main-screen';
  static const String onBoardingScreen = '/onboarding-screen';
  static const String homeScreen = '/home-screen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case mainScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
