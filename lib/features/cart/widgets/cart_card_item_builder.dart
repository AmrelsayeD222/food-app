import 'package:flutter/material.dart';
import 'package:foods_app/features/cart/data/model/cart_response_model.dart';
import 'cart_card_item.dart';

class CartCardItemBuilder extends StatelessWidget {
  final List<CartItem> items;

  const CartCardItemBuilder({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 10, left: 8, right: 8, top: 10),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return CartCardItem(item: items[index]);
      },
    );
  }
}
