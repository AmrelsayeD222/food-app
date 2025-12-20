import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton(
      {super.key,
      required this.child,
      required this.onpressed,
      this.backGroundColor,
      this.foreGroundColor});
  final Widget child;
  final VoidCallback? onpressed;
  final Color? backGroundColor;
  final Color? foreGroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          side: const BorderSide(color: AppColors.white),
          backgroundColor: backGroundColor ?? AppColors.white,
          foregroundColor: foreGroundColor ?? AppColors.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          minimumSize: const Size(double.infinity, 50),
        ),
        onPressed: onpressed,
        child: child);
  }
}
