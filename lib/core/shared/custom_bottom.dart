import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CustomBottom extends StatelessWidget {
  const CustomBottom(
      {super.key,
      required this.text,
      this.height,
      this.borderRadius,
      this.width,
      this.backgroundColor,
      this.foregroundColor,
      this.onPressed});
  final String text;
  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primary,
        foregroundColor: foregroundColor ?? AppColors.white,
        minimumSize: Size(width ?? 200, height ?? 70),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 20),
        ),
      ),
      child: Text(text),
    );
  }
}
