import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/core/di/service_locator.dart';
import 'package:foods_app/features/auth/manager/get_profile_data_cubit/get_profile_data_cubit.dart';

import '../../features/auth/views/login_view.dart';
import '../../features/auth/views/sign_up_view.dart';
import '../../features/auth/manager/login_cubit/loign_cubit.dart';
import '../../features/auth/manager/sign_up_cubit/sign_up_cubit.dart';

import '../../features/productDetalis/view/product_detalis_view.dart';
import '../../features/productDetalis/data/manager/cubit/order_request_cubit.dart';

import '../../features/checkout/views/checkout_view.dart';
import '../../features/checkout/widgets/success_dialog.dart';
import '../../features/cart/views/cart_view.dart';
import 'bottom_navi_bar.dart';
import '../../features/home/data/model/home_product_model.dart';

class AppRoutes {
  static const login = '/loginView';
  static const signUp = '/signUpView';
  static const bottomNaviBar = '/bottomNaviBar';
  static const productDetalisView = '/productDetalisView';
  static const checkoutView = '/checkoutView';
  static const successDialog = '/successDialog';
  static const cartView = '/CartView';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => getIt<LoginCubit>(),
              ),
              BlocProvider(
                create: (_) => getIt<GetProfileDataCubit>(),
              ),
            ],
            child: const LoginView(),
          ),
        );

      case signUp:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => getIt<SignUpCubit>(),
              ),
              BlocProvider(
                create: (_) => getIt<GetProfileDataCubit>(),
              ),
            ],
            child: const SignUpView(),
          ),
        );
      case bottomNaviBar:
        return MaterialPageRoute(
          builder: (_) => const BottomNaviBar(),
        );

      case productDetalisView:
        final product = settings.arguments;
        if (product is! Product) {
          return _undefinedRoute();
        }

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<OrderRequestCubit>(),
            child: ProductDetalisView(product: product),
          ),
        );

      case checkoutView:
        return MaterialPageRoute(
          builder: (_) => const CheckoutView(),
        );

      case successDialog:
        return MaterialPageRoute(
          builder: (_) => const SuccessDialog(),
        );

      case cartView:
        return MaterialPageRoute(
          builder: (_) => const CartView(),
        );

      default:
        return _undefinedRoute();
    }
  }

  static Route<dynamic> _undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(child: Text('Route not found')),
      ),
    );
  }
}
