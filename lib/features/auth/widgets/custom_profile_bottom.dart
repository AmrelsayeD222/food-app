import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/helper/spacing.dart';

class CustomProfileBottom extends StatelessWidget {
  const CustomProfileBottom({
    super.key,
    required this.text,
    required this.backColor,
    required this.foreColor,
    required this.icon,
    this.onpressed,
  });
  final String text;
  final Color backColor;
  final Color foreColor;
  final IconData icon;
  final void Function()? onpressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(5.w),
        backgroundColor: backColor,
        foregroundColor: foreColor,
        minimumSize: Size(190.w, 60.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: BorderSide(color: AppColors.primary, width: 2.w),
        ),
      ),
      child: Row(
        children: [
          Text(text),
          horizontalSpace(20),
          Icon(icon),
        ],
      ),
    );
  }
}
