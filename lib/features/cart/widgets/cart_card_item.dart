import 'package:flutter/material.dart';
import 'package:foods_app/features/cart/data/model/cart_response_model.dart';
import 'package:foods_app/features/cart/widgets/cart_item_image.dart';
import 'package:foods_app/features/cart/widgets/cart_item_info.dart';
import 'package:foods_app/features/cart/widgets/cart_item_remove_button.dart';
import 'package:foods_app/features/cart/widgets/cart_item_side_options.dart';
import 'package:foods_app/features/cart/widgets/cart_item_spicy_section.dart';
import 'package:foods_app/features/cart/widgets/cart_item_toppings.dart';

class CartCardItem extends StatelessWidget {
  final CartItem item;

  const CartCardItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final totalPrice = item.price * item.quantity;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: .1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CartItemImage(image: item.image),
              const SizedBox(width: 12),
              Expanded(
                child: CartItemInfo(
                  name: item.name,
                  quantity: item.quantity,
                  totalPrice: totalPrice,
                ),
              ),
              CartItemRemoveButton(itemId: item.itemId),
            ],
          ),
          if (item.spicy > 0) CartItemSpicySection(item: item),
          if (item.toppings.isNotEmpty)
            CartItemToppings(toppings: item.toppings),
          if (item.sideOptions.isNotEmpty)
            CartItemSideOptions(options: item.sideOptions),
        ],
      ),
    );
  }
}
