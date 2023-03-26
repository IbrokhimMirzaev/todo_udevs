import 'package:flutter/material.dart';
import 'package:todo_udevs/ui/on_boarding/on_boarding_page.dart';
import 'package:todo_udevs/ui/tab/tab_screen.dart';
import 'package:todo_udevs/utils/constants/route_names.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.onBoarding:
        return MaterialPageRoute(
          builder: (_) => const OnBoardingPage(),
        );
      case RouteNames.tab:
        return MaterialPageRoute(
          builder: (_) => const TabScreen(),
        );
      default:
        return null;
    }
  }
}
