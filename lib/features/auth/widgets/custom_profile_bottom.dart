import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/helper/spacing.dart';

class CustomProfileBottom extends StatelessWidget {
  const CustomProfileBottom({
    super.key,
    required this.text,
    required this.backColor,
    required this.foreColor,
    required this.icon,
  });
  final String text;
  final Color backColor;
  final Color foreColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(5),
        backgroundColor: backColor,
        foregroundColor: foreColor,
        minimumSize: const Size(200, 70),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.primary, width: 2),
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
