import 'package:flutter/material.dart';
import 'package:foods_app/core/constants/app_colors.dart';
import 'package:foods_app/core/shared/custom_bottom.dart';

import '../../../core/helper/spacing.dart';
import '../../../core/helper/text_style.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: AlertDialog(
        backgroundColor: AppColors.white,
        contentPadding: const EdgeInsets.all(16.0),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              child: Icon(Icons.check, size: 50),
            ),
            verticalSpace(20),
            const Text('Success !', style: TextStyles.textStyle30),
            const SizedBox(height: 12),
            Text(
              'Your payment was successful.\nA receipt for this purchase has been sent to your email.',
              style: TextStyles.textStyle14.copyWith(color: AppColors.grey),
              textAlign: TextAlign.center,
            ),
            verticalSpace(20),
            CustomBottom(
              text: 'Go Back',
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      ),
    );
  }
}
