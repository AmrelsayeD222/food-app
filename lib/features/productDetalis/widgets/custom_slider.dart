import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/helper/spacing.dart';
import '../../../core/helper/text_style.dart';

class CustomSlider extends StatefulWidget {
  final double initialValue;
  final ValueChanged<double> onChanged;

  const CustomSlider({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  late double value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpace(10),
        Slider(
          padding: EdgeInsets.zero,
          value: value,
          min: 0,
          max: 1,
          divisions: 10,
          activeColor: AppColors.primary,
          inactiveColor: AppColors.greyLight,
          thumbColor: AppColors.primary,
          onChanged: (newValue) {
            setState(() {
              value = newValue;
            });
            widget.onChanged(newValue);
          },
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('🥶', style: TextStyle(fontSize: 16)),
            Text('🌶️', style: TextStyle(fontSize: 16)),
          ],
        ),
        Text(
          'Spicy',
          style: TextStyles.textStyle14.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
