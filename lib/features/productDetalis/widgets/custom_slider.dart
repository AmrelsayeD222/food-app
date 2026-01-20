import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  String _getSpicyLabel() {
    if (value == 0) return 'Not Spicy';
    if (value <= 0.3) return 'Mild';
    if (value <= 0.6) return 'Medium';
    if (value <= 0.8) return 'Hot';
    return 'Extra Hot';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpace(10.h),

        // Spicy Label
        Text(
          _getSpicyLabel(),
          style: TextStyles.textStyle14.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),

        verticalSpace(8.h),

        // Slider
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 4.h,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.r),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 16.r),
            activeTrackColor: AppColors.primary,
            inactiveTrackColor: AppColors.greyLight,
            thumbColor: AppColors.primary,
            overlayColor: AppColors.primary.withAlpha(51),
          ),
          child: Slider(
            value: value,
            min: 0,
            max: 1,
            divisions: 10,
            onChanged: (newValue) {
              setState(() {
                value = newValue;
              });
              widget.onChanged(newValue);
            },
          ),
        ),

        // Fire Icons Row with Padding
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              5,
              (index) {
                // حساب مستوى التوابل (0-5)
                double spicyLevel = value * 5;

                return Icon(
                  Icons.local_fire_department,
                  size: 24.sp,
                  color: index < spicyLevel ? Colors.red : Colors.grey[300],
                );
              },
            ),
          ),
        ),

        verticalSpace(8.h),

        // Min/Max Labels
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Not Spicy',
                style: TextStyles.textStyle14.copyWith(
                  color: Colors.grey[600],
                  fontSize: 12.sp,
                ),
              ),
              Text(
                'Extra Hot',
                style: TextStyles.textStyle14.copyWith(
                  color: Colors.grey[600],
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
