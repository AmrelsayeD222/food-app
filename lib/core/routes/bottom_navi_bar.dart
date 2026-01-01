// bottom_navi_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/core/constants/app_colors.dart';
import 'package:foods_app/core/helper/shared_pref_storage.dart';
import 'package:foods_app/core/routes/app_routes.dart';

import 'package:foods_app/features/auth/views/profile_view.dart';
import 'package:foods_app/features/cart/data/manager/cartCubit/cart_cubit_cubit.dart';
import 'package:foods_app/features/cart/views/cart_view.dart';
import 'package:foods_app/features/home/data/manager/cubit/home_product_cubit.dart';
import 'package:foods_app/features/home/views/home_view.dart';
import 'package:foods_app/features/orderHistory/views/order_history_view.dart';

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
  String? token;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _viewController = PageController(initialPage: _selectedIndex);
    _loadTokenAndInitViews();
  }

  Future<void> _loadTokenAndInitViews() async {
    token = await SharedPrefsService().getToken();

    views = [
      BlocProvider(
        create: (context) =>
            HomeProductCubit(AppRoutes.homeRepo)..fetchProduct(),
        child: const HomeView(),
      ),
      BlocProvider(
        create: (_) =>
            CartCubitCubit(AppRoutes.cartRepo)..getCart(token: token ?? ''),
        child: const CartView(),
      ),
      const OrderHistoryView(),
      const ProfileView(),
    ];

    setState(() {}); // rebuild بعد ما views تجهز
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
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _viewController,
          children: views!,
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
              iconSize: 30,
              selectedFontSize: 15,
              unselectedFontSize: 12,
              elevation: 0,
              currentIndex: _selectedIndex,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart), label: "Cart"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.restaurant_sharp),
                    label: "Orders History"),
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
    );
  }
}
