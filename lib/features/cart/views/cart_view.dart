import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/core/helper/spacing.dart';
import 'package:foods_app/features/cart/data/manager/cartCubit/cart_cubit_cubit.dart';

import '../widgets/cart_card_item_builder.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CartCubitCubit, CartCubitState>(
        builder: (context, state) {
          if (state is CartCubitLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CartCubitFailure) {
            return Center(child: Text(state.errMessage));
          }

          if (state is CartCubitSuccess) {
            return Column(
              children: [
                verticalSpace(30),
                Expanded(
                  child: CartCardItemBuilder(items: state.cartResponse.items),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
      // bottomSheet: BlocBuilder<CartCubitCubit, CartCubitState>(
      //   builder: (context, state) {
      //     if (state is CartCubitSuccess) {
      //       return CustomBottomSheet(
      //         onpressed: () {
      //           context.pushNamed(AppRoutes.checkoutView);
      //         },
      //         bottomText: 'CheckOut',
      //         sheetText: 'Total',
      //         price: '\$${state.cartResponse.totalPrice}',
      //       );
      //     }
      //     return const SizedBox.shrink();
      //   },
      // ),
    );
  }
}
