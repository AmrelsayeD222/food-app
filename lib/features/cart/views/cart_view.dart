import 'package:flutter/material.dart';
import 'package:foods_app/core/helper/navigation_extentions.dart';
import 'package:foods_app/core/helper/spacing.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/shared/custom_bottom_sheet.dart';
import '../widgets/cart_card_item_builder.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: CustomBottomSheet(
        onpressed: () {
          context.pushNamed(AppRoutes.checkoutView);
        },
        bottomText: 'CheckOut',
        sheetText: 'Total',
        price: '\$20.00',
      ),
      body: Column(children: [
        verticalSpace(30),
        const Expanded(child: CartCardItemBuilder()),
      ]),
    );
  }
}
