import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/core/constants/app_colors.dart';
import 'package:foods_app/core/helper/navigation_extentions.dart';
import 'package:foods_app/core/helper/spacing.dart';
import 'package:foods_app/core/helper/text_style.dart';
import 'package:foods_app/core/routes/app_routes.dart';
import 'package:foods_app/features/cart/data/manager/cartCubit/cart_cubit_cubit.dart';
import 'package:foods_app/features/cart/data/model/cart_response_model.dart';
import 'package:foods_app/features/cart/widgets/cart_card_item_builder.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubitCubit, CartCubitState>(
      builder: (context, state) {
        if (state is CartCubitLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
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
                  child: CartCardItemBuilder(items: items),
                ),
              ],
            ),
            bottomNavigationBar: _buildCheckoutBottomSheet(context, items),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildCheckoutBottomSheet(BuildContext context, List<CartItem> items) {
    final totalPrice = items.fold(
      0.0,
      (sum, item) => sum + (item.price * item.quantity),
    );

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: AppColors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:',
                  style: TextStyles.textStyle20.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${totalPrice.toStringAsFixed(2)}',
                  style: TextStyles.textStyle20.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: items.isEmpty
                  ? null
                  : () {
                      context.pushNamed(
                        AppRoutes.checkoutView,
                        arguments: items,
                      );
                    },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Checkout',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
