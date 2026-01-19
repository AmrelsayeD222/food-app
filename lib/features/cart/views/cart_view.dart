import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:foods_app/core/constants/app_colors.dart';
import 'package:foods_app/core/helper/spacing.dart';

import 'package:foods_app/features/cart/data/manager/getCartCubit/cart_cubit_cubit.dart';
import 'package:foods_app/features/cart/data/model/cart_response_model.dart';
import 'package:foods_app/features/cart/widgets/cart_card_item_builder.dart';
import 'package:foods_app/features/cart/widgets/check_out_bottom.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  List<CartItem> _getDummyItems() {
    return List.generate(
      5,
      (index) => CartItem(
        itemId: index,
        productId: index,
        name: 'Dataset Name',
        image: 'https://via.placeholder.com/150',
        quantity: 1,
        price: 100.0,
        spicy: 0,
        toppings: [],
        sideOptions: [],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubitCubit, CartCubitState>(
      builder: (context, state) {
        if (state is CartCubitLoading) {
          return Scaffold(
            body: Skeletonizer(
              enabled: true,
              child: Column(
                children: [
                  verticalSpace(30),
                  Expanded(
                    child: CartCardItemBuilder(
                      items: _getDummyItems(),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is CartCubitEmpty) {
          return Scaffold(
            body: Center(
              child: Text(
                state.message,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          );
        }

        if (state is CartCubitFailure) {
          return Scaffold(
            body: Center(child: Text(state.errMessage)),
          );
        }

        if (state is CartCubitSuccess) {
          final items = state.cartResponse.items;

          return Scaffold(
            body: Column(
              children: [
                verticalSpace(30),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await context
                          .read<CartCubitCubit>()
                          .getCart(forceRefresh: true);
                    },
                    color: AppColors.primary,
                    child: CartCardItemBuilder(items: items),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: checkoutBottomSheet(context, items),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
