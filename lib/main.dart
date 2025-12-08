import 'package:flutter/material.dart';
import 'package:foods_app/core/routes/bottom_navi_bar.dart';

import 'core/routes/app_routes.dart';

void main() {
  runApp(const HungryApp());
}

class HungryApp extends StatelessWidget {
  const HungryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      onGenerateRoute: AppRoutes.generateRoute,
      debugShowCheckedModeBanner: false,
      home: const BottomNaviBar(),
    );
  }
}
