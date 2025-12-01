import 'package:flutter/material.dart';

import 'core/routes/app_routes.dart';
import 'core/routes/bottom_navi_bar.dart';

void main() {
  runApp(const HungryApp());
}

class HungryApp extends StatelessWidget {
  const HungryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      onGenerateRoute: AppRoutes.generateRoute,
      debugShowCheckedModeBanner: false,
      home: BottomNaviBar(),
    );
  }
}
