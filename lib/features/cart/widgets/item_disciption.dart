import 'package:flutter/material.dart';
import 'package:foods_app/features/cart/data/model/cart_response_model.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/helper/text_style.dart';

class ItemDescription extends StatelessWidget {
  final CartItem item;

  const ItemDescription({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    double totalPrice = item.price * item.quantity;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: .1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  item.image,
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill, // ✅ غيرت من fill لـ cover
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: TextStyles.textStyle16.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${totalPrice.toStringAsFixed(2)}',
                      style: TextStyles.textStyle16.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Quantity: ${item.quantity}',
                        style: TextStyles.textStyle14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (item.spicy > 0) ...[
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.local_fire_department,
                    color: Colors.red, size: 20),
                const SizedBox(width: 6),
                Text(
                  'Spicy Level:',
                  style: TextStyles.textStyle14.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
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
                )
              ],
            ),
          ],
          if (item.toppings.isNotEmpty) ...[
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.restaurant, size: 18),
                const SizedBox(width: 6),
                Text(
                  'Toppings',
                  style: TextStyles.textStyle14.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: item.toppings.map((topping) {
                return _buildOptionChip(topping);
              }).toList(),
            ),
          ],
          if (item.sideOptions.isNotEmpty) ...[
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.dining, size: 18),
                const SizedBox(width: 6),
                Text(
                  'Side Options',
                  style: TextStyles.textStyle14.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: item.sideOptions.map((option) {
                return _buildOptionChip(option);
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOptionChip(CartOption option) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.black.withValues(alpha: .05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.black.withValues(alpha: .1),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (option.image.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                option.image,
                width: 20,
                height: 20,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.fastfood, size: 16);
                },
              ),
            ),
          if (option.image.isNotEmpty) const SizedBox(width: 6),
          Text(
            option.name,
            style: TextStyles.textStyle14.copyWith(
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
