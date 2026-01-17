import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton(
      {super.key,
      required this.child,
      required this.onpressed,
      this.backGroundColor,
      this.width,
      this.height,
      this.foreGroundColor});
  final Widget child;
  final VoidCallback? onpressed;
  final Color? backGroundColor;
  final Color? foreGroundColor;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backGroundColor ?? AppColors.white,
          foregroundColor: foreGroundColor ?? AppColors.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          minimumSize: Size(width ?? 0, height ?? 50.h),
        ),
        onPressed: onpressed,
        child: child);
  }
}
