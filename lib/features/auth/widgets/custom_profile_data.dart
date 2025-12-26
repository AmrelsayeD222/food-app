import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/helper/spacing.dart';
import '../../../core/shared/custom_text_form_field.dart';

class CustomProfiledata extends StatelessWidget {
  const CustomProfiledata({
    super.key,
    required this.profileNameController,
    required this.profileEmailController,
    required this.profileAddressController,
  });

  final TextEditingController profileNameController;
  final TextEditingController profileEmailController;
  final TextEditingController profileAddressController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpace(40),
        CustomTextFormField(
          fillColor: AppColors.white,
          controller: profileNameController,
          label: 'Name',
        ),
        verticalSpace(20),
        CustomTextFormField(
          fillColor: AppColors.white,
          controller: profileEmailController,
          label: 'Email',
        ),
        verticalSpace(20),
        CustomTextFormField(
          fillColor: AppColors.white,
          controller: profileAddressController,
          label: 'Address',
        ),
        verticalSpace(40),
      ],
    );
  }
}
