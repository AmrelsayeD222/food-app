import 'package:flutter/material.dart';
import 'package:foods_app/core/constants/app_colors.dart';
import 'package:foods_app/core/helper/spacing.dart';

import '../widgets/custom_profile_bottom.dart';
import '../widgets/custom_profile_data.dart';
import '../widgets/custom_profile_image.dart';
import '../widgets/profile_visa_tile.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController profileNameController = TextEditingController();

  final TextEditingController profileEmailController = TextEditingController();
  final TextEditingController profileAddressController =
      TextEditingController();
  @override
  void dispose() {
    profileNameController.dispose();
    profileEmailController.dispose();
    profileAddressController.dispose();
    super.dispose();
  }

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
      bottomSheet: Container(
        color: AppColors.white,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomProfileBottom(
              text: 'Edit Profile',
              backColor: AppColors.white,
              foreColor: AppColors.primary,
              icon: Icons.edit,
            ),
            CustomProfileBottom(
              text: 'Log out',
              backColor: AppColors.primary,
              foreColor: AppColors.white,
              icon: Icons.logout,
            )
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const CustomProfileImage(),
              CustomProfiledata(
                  profileNameController: profileNameController,
                  profileEmailController: profileEmailController,
                  profileAddressController: profileAddressController),
              const ProfileVisaTile()
            ],
          ),
        ),
      ),
    );
  }
}
