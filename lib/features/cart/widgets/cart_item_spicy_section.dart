import 'package:flutter/material.dart';
import 'package:foods_app/features/cart/data/model/cart_response_model.dart';
import 'package:foods_app/features/cart/widgets/item_spicy_bar.dart';

class CartItemSpicySection extends StatelessWidget {
  final CartItem item;

  const CartItemSpicySection({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        const Divider(height: 1),
        const SizedBox(height: 12),
        ItemSpicyBar(item: item),
      ],
    );
  }
}
