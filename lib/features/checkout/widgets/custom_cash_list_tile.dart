import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/helper/spacing.dart';
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
      borderRadius: BorderRadius.circular(16.r),
      onTap: onTap,
      child: Container(
        height: 80.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: AppColors.brown,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 2.w,
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              'assets/detalis/dollar_Background_Removed.png',
              width: 40.w,
            ),
            horizontalSpace(16.w),
            Expanded(
              child: Text(
                'Cash on Delivery',
                style: TextStyles.textStyle16.copyWith(color: AppColors.white),
              ),
            ),

            /// ✔️ Custom indicator
            Container(
              width: 22.w,
              height: 22.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.primary : Colors.transparent,
                border: Border.all(
                  color: AppColors.white,
                  width: 2.w,
                ),
              ),
              child: isSelected
                  ? Icon(Icons.check, size: 14.sp, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
