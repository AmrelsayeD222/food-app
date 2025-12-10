import 'package:flutter/material.dart';
import 'package:foods_app/core/helper/spacing.dart';

import '../../../core/shared/custom_bottom_sheet.dart';
import '../../checkout/views/checkout_view.dart';
import '../widgets/cart_card_item_builder.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: CustomBottomSheet(
        onpressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CheckoutView()));
        },
        text: 'CheckOut',
        price: '\$20.00',
      ),
      body: Column(children: [
        verticalSpace(30),
        const Expanded(child: CartCardItemBuilder()),
      ]),
    );
  }
}
