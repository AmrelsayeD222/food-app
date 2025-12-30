import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/features/auth/manager/sign_up_cubit/sign_up_cubit.dart';
import 'package:foods_app/features/cart/views/cart_view.dart';
import 'package:foods_app/features/home/data/model/home_product_model.dart';
import 'package:foods_app/features/productDetalis/data/manager/cubit/order_request_cubit.dart';
import 'package:foods_app/features/productDetalis/data/repo/product_detalis_repoimpl.dart';

import '../../features/auth/data/repo/repo_impl.dart';
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
  static const cartView = '/CartView';

  static final Dio dio = Dio();
  static final ApiServices apiServices = ApiServices(dio);
  static final SharedPrefsService prefsService = SharedPrefsService();

  static final RepoImpl loginRepo = RepoImpl(apiServices, prefsService);
  static final RepoImpl signUpRepo = RepoImpl(apiServices, prefsService);
  static final ProductDetalisRepoimpl productDetalisRepo =
      ProductDetalisRepoimpl(apiServices);

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
          builder: (_) => BlocProvider(
            create: (_) => SignUpCubit(signUpRepo),
            child: const SignUpView(),
          ),
        );

      case bottomNaviBar:
        return MaterialPageRoute(
          builder: (_) => const BottomNaviBar(),
        );

      case AppRoutes.productDetalisView:
        final product = settings.arguments;

        if (product == null || product is! Product) {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(child: Text('Product not found')),
            ),
          );
        }

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => OrderRequestCubit(productDetalisRepo),
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
