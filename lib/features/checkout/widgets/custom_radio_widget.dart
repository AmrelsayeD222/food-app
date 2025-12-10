import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class CustomRadioWidget extends StatelessWidget {
  const CustomRadioWidget({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  final String value;
  final String groupValue;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Radio<String>(
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      activeColor: AppColors.red,
    );
  }
}
