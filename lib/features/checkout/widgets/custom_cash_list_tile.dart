import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/helper/text_style.dart';

class CustomCashListTile extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;

  const CustomCashListTile({
    super.key,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.brown,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              'assets/detalis/dollar_Background_Removed.png',
              width: 40,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                'Cash on Delivery',
                style: TextStyles.textStyle16.copyWith(color: AppColors.white),
              ),
            ),

            /// ✔️ Custom indicator
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.primary : Colors.transparent,
                border: Border.all(
                  color: AppColors.white,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
