import 'package:flutter/material.dart';
import 'package:foods_app/core/helper/text_style.dart';

class CartItemInfo extends StatelessWidget {
  final String name;
  final int quantity;
  final double totalPrice;

  const CartItemInfo({
    super.key,
    required this.name,
    required this.quantity,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name,
            style: TextStyles.textStyle16.copyWith(
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(height: 4),
        Text('\$${totalPrice.toStringAsFixed(2)}',
            style: TextStyles.textStyle16),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text('Quantity: $quantity', style: TextStyles.textStyle14),
        ),
      ],
    );
  }
}
