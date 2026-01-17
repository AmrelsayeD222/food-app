import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foods_app/core/constants/app_colors.dart';
import 'package:foods_app/core/helper/navigation_extentions.dart';
import 'package:foods_app/core/routes/app_routes.dart';

class GuestProfile extends StatelessWidget {
  const GuestProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 300.h),
        const Text('You are not logged in !!!'),
        SizedBox(height: 20.h),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
            ),
            onPressed: () {
              context.pushReplacementNamed(AppRoutes.signUp);
            },
            child: const Text('Log in '))
      ],
    );
  }
}
