import 'package:flutter/material.dart';
import 'package:foods_app/features/auth/views/sign_up_view.dart';

import 'core/routes/app_routes.dart';

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
      home: SignUpView(),
    );
  }
}
