import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/helper/spacing.dart';
import '../../../core/helper/text_style.dart';

class ProfileSkeleton extends StatelessWidget {
  const ProfileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image Skeleton
            Center(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.greyLight,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: SizedBox(
                  width: 150.w,
                  height: 150.h,
                ),
              ),
            ),
            verticalSpace(20),

            // Update Image Button Skeleton (shape only)
            Center(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.greyLight,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: SizedBox(
                  width: 120.w,
                  height: 40.h,
                ),
              ),
            ),
            verticalSpace(30),

            // Profile Info Skeletons
            Text(
              'Nameeeeeeeeeeeeeeee:',
              style: TextStyles.textStyle18,
            ),
            verticalSpace(20),

            Text(
              'Emailllllllllll:',
              style: TextStyles.textStyle18,
            ),
            verticalSpace(20),

            Text(
              'Addresssssssssssssss:',
              style: TextStyles.textStyle18,
            ),
            verticalSpace(20),

            // Visa Tile Skeleton
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.greyLight,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: ListTile(
                minTileHeight: 80.h,
                leading: SizedBox(
                  width: 60.w,
                  height: 40.h,
                ),
                title: Text(
                  'Debit card',
                  style: TextStyles.textStyle14,
                ),
                subtitle: Text(
                  '**** **** **** ****',
                  style: TextStyles.textStyle14,
                ),
                trailing: Text(
                  'Default',
                  style: TextStyles.textStyle14,
                ),
              ),
            ),
            verticalSpace(20),
          ],
        ),
      ),
    );
  }
}
