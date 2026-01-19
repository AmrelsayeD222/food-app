import 'package:flutter/material.dart';
import 'package:foods_app/core/helper/text_style.dart';
import 'package:foods_app/features/cart/data/model/cart_response_model.dart';
import 'cart_option_chip.dart';

class CartItemSideOptions extends StatelessWidget {
  final List<CartOption> options;

  const CartItemSideOptions({
    super.key,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        const Divider(height: 1),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.dining, size: 18),
            const SizedBox(width: 6),
            Text(
              'Side Options',
              style:
                  TextStyles.textStyle14.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((e) => CartOptionChip(option: e)).toList(),
        ),
      ],
    );
  }
}
