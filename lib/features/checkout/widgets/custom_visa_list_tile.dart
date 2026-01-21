import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/helper/spacing.dart';
import '../../../core/helper/text_style.dart';

class CustomVisaListTile extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;

  const CustomVisaListTile({
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
        height: 85.h,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF1E3A8A).withValues(alpha: 0.9),
              const Color(0xFF3B82F6).withValues(alpha: 0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : Colors.white.withValues(alpha: 0.3),
            width: 2.w,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Image.asset(
                'assets/detalis/visa.png',
                width: 50.w,
                fit: BoxFit.contain,
              ),
            ),
            horizontalSpace(16.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Debit Card',
                    style: TextStyles.textStyle14.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  verticalSpace(2.h),
                  Text(
                    '3566 **** **** 0505',
                    style: TextStyles.textStyle14.copyWith(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 12.sp,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 24.w,
              height: 24.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.primary : Colors.transparent,
                border: Border.all(
                  color: Colors.white,
                  width: 2.w,
                ),
              ),
              child: isSelected
                  ? Icon(Icons.check, size: 16.sp, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
