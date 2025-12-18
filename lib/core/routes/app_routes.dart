import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/data/repo/login_repo_impl.dart';
import '../../features/auth/manager/login_cubit/loign_cubit.dart';
import '../../features/auth/views/login_view.dart';
import '../../features/auth/views/sign_up_view.dart';
import '../../features/checkout/views/checkout_view.dart';
import '../../features/checkout/widgets/success_dialog.dart';
import '../../features/productDetalis/view/product_detalis_view.dart';
import '../helper/shared_pref_storage.dart';
import '../network/services/api_service.dart';
import 'bottom_navi_bar.dart';

class AppRoutes {
  static const login = '/loginView';
  static const signUp = '/signUpView';
  static const bottomNaviBar = '/bottomNaviBar';
  static const productDetalisView = '/productDetalisView';
  static const checkoutView = '/checkoutView';
  static const successDialog = '/successDialog';
  static final Dio dio = Dio();
  static final ApiServices apiServices = ApiServices(dio);
  static final SharedPrefsService prefsService = SharedPrefsService();

  static final LoginRepoImpl loginRepo =
      LoginRepoImpl(apiServices, prefsService);

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => LoginCubit(loginRepo),
            child: const LoginView(),
          ),
        );

      case signUp:
        return MaterialPageRoute(
          builder: (_) => const SignUpView(),
        );

      case bottomNaviBar:
        return MaterialPageRoute(
          builder: (_) => const BottomNaviBar(),
        );

      case productDetalisView:
        return MaterialPageRoute(
          builder: (_) => const ProductDetalisView(),
        );

      case checkoutView:
        return MaterialPageRoute(
          builder: (_) => const CheckoutView(),
        );

      case successDialog:
        return MaterialPageRoute(
          builder: (_) => const SuccessDialog(),
        );

      default:
        return _undefinedRoute();
    }
  }

  static Route<dynamic> _undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text(
            'Route not found',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
