import 'package:flutter/material.dart';
import 'package:foods_app/core/helper/spacing.dart';

import '../../../core/constants/app_colors.dart';
import '../widgets/custom_cart_bottom.dart';
import '../widgets/cart_card_item_builder.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: AppColors.white,
        height: 110,
        child: const Padding(
          padding: EdgeInsets.all(14.0),
          child: CustomCartBottom(
            text: 'CheckOut',
            price: '\$99.19',
          ),
        ),
      ),
      body: Column(children: [
        verticalSpace(30),
        const Expanded(child: CartCardItemBuilder()),
      ]),
    );
  }
}
