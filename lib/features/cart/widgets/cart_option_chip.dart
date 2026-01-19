import 'package:flutter/material.dart';
import 'package:foods_app/core/constants/app_colors.dart';
import 'package:foods_app/core/helper/text_style.dart';
import 'package:foods_app/features/cart/data/model/cart_response_model.dart';

class CartOptionChip extends StatelessWidget {
  final CartOption option;

  const CartOptionChip({super.key, required this.option});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.black.withValues(alpha: .05),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (option.image.isNotEmpty)
            Image.network(option.image, width: 20, height: 20),
          if (option.image.isNotEmpty) const SizedBox(width: 6),
          Text(option.name, style: TextStyles.textStyle14),
        ],
      ),
    );
  }
}
