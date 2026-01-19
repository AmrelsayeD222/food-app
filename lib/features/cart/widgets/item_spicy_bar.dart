import 'package:flutter/material.dart';
import 'package:foods_app/core/helper/text_style.dart';
import 'package:foods_app/features/cart/data/model/cart_response_model.dart';

class ItemSpicyBar extends StatelessWidget {
  const ItemSpicyBar({
    super.key,
    required this.item,
  });

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.local_fire_department, color: Colors.red, size: 20),
        const SizedBox(width: 6),
        Text(
          'Spicy Level:',
          style: TextStyles.textStyle14.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: 8),
        ...List.generate(
          5,
          (index) {
            double spicyLevel = item.spicy * 5;
            return Icon(
              Icons.local_fire_department,
              size: 24,
              color: index < spicyLevel ? Colors.red : Colors.grey[300],
            );
          },
        ),
      ],
    );
  }
}
