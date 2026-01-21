import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foods_app/core/constants/app_colors.dart';
import 'package:foods_app/core/di/service_locator.dart';
import 'package:foods_app/core/helper/shared_pref_storage.dart';
import 'package:foods_app/core/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  setupServiceLocator();

  final token = await getIt<SharedPrefsService>().getToken();
  final hasToken = token != null && token.isNotEmpty;
  log(token.toString());
  runApp(HungryApp(
      initialRoute: hasToken ? AppRoutes.bottomNaviBar : AppRoutes.signUp));
}

class HungryApp extends StatelessWidget {
  final String initialRoute;
  const HungryApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.greyLight,
            appBarTheme:
                const AppBarTheme(backgroundColor: AppColors.greyLight),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: initialRoute,
          onGenerateRoute: AppRoutes.generateRoute,
        );
      },
    );
  }
}
