import 'package:flutter/material.dart';
import 'package:foods_app/core/routes/bottom_navi_bar.dart';

import '../../features/auth/views/login_view.dart';
import '../../features/auth/views/sign_up_view.dart';
import '../../features/checkout/views/checkout_view.dart';
import '../../features/checkout/widgets/success_dialog.dart';
import '../../features/productDetalis/view/product_detalis_view.dart';

class AppRoutes {
  static const login = '/loginView';
  static const signUp = '/signUpView';
  static const bottomNaviBar = '/bottomNaviBar';
  static const productDetalisView = '/productDetalisView';
  static const checkoutView = '/checkoutView';
  static const successDialog = '/successDialog';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case signUp:
        return MaterialPageRoute(builder: (_) => const SignUpView());
      case bottomNaviBar:
        return MaterialPageRoute(builder: (_) => const BottomNaviBar());
      case productDetalisView:
        return MaterialPageRoute(builder: (_) => const ProductDetalisView());
      case checkoutView:
        return MaterialPageRoute(builder: (_) => const CheckoutView());
      case successDialog:
        return MaterialPageRoute(builder: (_) => const SuccessDialog());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}
