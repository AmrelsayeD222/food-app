import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class CustomRadioWidget extends StatelessWidget {
  const CustomRadioWidget({
    super.key,
    required this.value,
  });

  final String value;

  @override
  Widget build(BuildContext context) {
    return Radio<String>(
      value: value,
      activeColor: AppColors.red,
    );
  }
}
