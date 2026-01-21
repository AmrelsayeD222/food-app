import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foods_app/core/constants/app_colors.dart';
import 'package:foods_app/core/helper/spacing.dart';
import 'package:foods_app/core/helper/text_style.dart';

Widget buildInfoCard({
  required IconData icon,
  required String label,
  required String value,
}) {
  return Container(
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10.r,
          offset: Offset(0, 4.h),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 24.sp,
          ),
        ),
        horizontalSpace(16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyles.textStyle14.copyWith(
                  color: Colors.grey.shade600,
                  fontSize: 12.sp,
                ),
              ),
              verticalSpace(4.h),
              Text(
                value,
                style: TextStyles.textStyle18.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
