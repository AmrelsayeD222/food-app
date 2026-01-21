import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foods_app/core/constants/app_colors.dart';
import 'package:foods_app/core/helper/navigation_extentions.dart';
import 'package:foods_app/core/helper/spacing.dart';
import 'package:foods_app/core/routes/app_routes.dart';

class GuestProfile extends StatelessWidget {
  const GuestProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, size: 100.sp, color: Colors.grey.shade400),
          verticalSpace(16.h),
          const Text(
            'You are not logged in Yet',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          verticalSpace(16.h),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(120.w, 40.h),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
              ),
              onPressed: () {
                context.pushReplacementNamed(AppRoutes.signUp);
              },
              child: const Text('Log in '))
        ],
      ),
    );
  }
}
