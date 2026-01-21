// bottom_navi_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/core/constants/app_colors.dart';
import 'package:foods_app/core/di/service_locator.dart';
import 'package:foods_app/features/auth/manager/post_profile_data_cubit/post_profile_data_cubit.dart';
import 'package:foods_app/features/auth/manager/get_profile_data_cubit/get_profile_data_cubit.dart';
import 'package:foods_app/features/auth/views/profile_view.dart';
import 'package:foods_app/features/cart/data/manager/getCartCubit/cart_cubit_cubit.dart';
import 'package:foods_app/features/cart/data/manager/removeCart/remove_cubit.dart';
import 'package:foods_app/features/cart/views/cart_view.dart';
import 'package:foods_app/features/favourite/data/manager/toggle/fav_cubit.dart';
import 'package:foods_app/features/favourite/views/favourire_view.dart';
import 'package:foods_app/features/home/data/manager/cubit/home_product_cubit.dart';
import 'package:foods_app/features/home/views/home_view.dart';

class BottomNaviBar extends StatefulWidget {
  final int initialIndex;
  const BottomNaviBar({super.key, this.initialIndex = 0});

  @override
  State<BottomNaviBar> createState() => _BottomNaviBarState();
}

class _BottomNaviBarState extends State<BottomNaviBar> {
  late int _selectedIndex;
  late PageController _viewController;

  List<Widget>? views;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _viewController = PageController(initialPage: _selectedIndex);
    _initViews();
  }

  void _initViews() {
    views = [
      MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: getIt<HomeProductCubit>(),
          ),
          BlocProvider.value(
            value: getIt<GetProfileDataCubit>()
              ..getProfileData(forceRefresh: true),
          ),
          BlocProvider.value(
            value: getIt<FavCubit>(),
          ),
        ],
        child: const HomeView(),
      ),
      MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: getIt<CartCubitCubit>()..getCart(forceRefresh: true),
          ),
          BlocProvider.value(
            value: getIt<RemoveCubit>(),
          ),
        ],
        child: const CartView(),
      ),
      BlocProvider.value(
        value: getIt<FavCubit>(),
        child: const FavourireView(),
      ),
      MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: getIt<GetProfileDataCubit>()
              ..getProfileData(forceRefresh: true),
          ),
          BlocProvider(
            create: (_) => getIt<PostProfileDataCubit>(),
          ),
        ],
        child: const ProfileView(),
      ),
    ];

    setState(() {});
  }

  @override
  void dispose() {
    _viewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (views == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return PopScope(
      canPop: false,
      child: Scaffold(
        extendBody: true,
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _viewController,
          children: views!,
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: .3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.transparent,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white.withValues(alpha: .6),
                type: BottomNavigationBarType.fixed,
                iconSize: 26,
                selectedFontSize: 14,
                unselectedFontSize: 12,
                elevation: 0,
                currentIndex: _selectedIndex,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart), label: "Cart"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite_border), label: "Favourite"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: "Profile"),
                ],
                onTap: (index) {
                  _selectedIndex = index;
                  _viewController.jumpToPage(index);
                  setState(() {});
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
