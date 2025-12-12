import 'package:flutter/material.dart';
import 'package:foods_app/core/constants/app_colors.dart';
import 'package:foods_app/core/helper/spacing.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: const Icon(Icons.arrow_back, color: Colors.white),
        actions: [
          const Icon(Icons.settings, color: Colors.white),
          horizontalSpace(10)
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                border: Border.all(
                  color: Colors.white,
                  width: 5,
                ),
                image: const DecorationImage(
                  image: AssetImage(
                    'assets/detalis/sonic_profile.png',
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
