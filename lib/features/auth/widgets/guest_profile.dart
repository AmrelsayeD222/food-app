import 'package:flutter/material.dart';
import 'package:foods_app/core/constants/app_colors.dart';
import 'package:foods_app/core/helper/navigation_extentions.dart';
import 'package:foods_app/core/routes/app_routes.dart';

class GuestProfile extends StatelessWidget {
  const GuestProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 300),
        const Text('You are not logged in !!!'),
        const SizedBox(height: 20),
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
