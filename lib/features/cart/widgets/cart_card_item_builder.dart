import 'package:flutter/material.dart';

import 'cart_card_item.dart';

class CartCardItemBuilder extends StatelessWidget {
  const CartCardItemBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 110, left: 8, right: 8),
      itemCount: 10,
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.all(0),
          child: SizedBox(
            width: double.infinity,
            height: 200,
            child: CartCardItem(),
          ),
        );
      },
    );
  }
}
