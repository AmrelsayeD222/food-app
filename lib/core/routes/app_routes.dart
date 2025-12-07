import 'package:flutter/material.dart';

import '../../features/splash/splash_view.dart';
import '../../features/home/views/home_view.dart';

class AppRoutes {
  static const splash = '/';
  static const home = '/homeView';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeView());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}
