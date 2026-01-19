import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foods_app/core/constants/app_colors.dart';
import 'package:foods_app/core/helper/navigation_extentions.dart';
import 'package:foods_app/core/helper/spacing.dart';
import 'package:foods_app/core/shared/custom_bottom.dart';
import '../../../core/helper/text_style.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: AlertDialog(
        backgroundColor: AppColors.white,
        contentPadding: EdgeInsets.all(16.0.w),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 50.r,
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              child: Icon(Icons.check, size: 50.sp),
            ),
            verticalSpace(20.h),
            Text('Success !', style: TextStyles.textStyle30),
            verticalSpace(12.h),
            Text(
              'Your payment was successful.\nA receipt for this purchase has been sent to your email.',
              style: TextStyles.textStyle14.copyWith(color: AppColors.grey),
              textAlign: TextAlign.center,
            ),
            verticalSpace(20.h),
            CustomBottom(
              text: 'Go Back',
              onPressed: () => context.pop(),
            )
          ],
        ),
      ),
    );
  }
}
