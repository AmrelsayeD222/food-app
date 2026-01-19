import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryBottm extends StatelessWidget {
  const CategoryBottm({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.foregroundColor,
    this.onPressed,
  });
  final String text;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
