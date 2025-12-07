import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/helper/spacing.dart';
import '../../../core/helper/text_style.dart';
import 'custom_track_shape.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({
    super.key,
  });

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double initvalue = .5;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpace(10),
        Text(
          'Spicy',
          style: TextStyles.textStyle14.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        SliderTheme(
          data: SliderThemeData(
            trackShape: CustomTrackShape(),
          ),
          child: Slider(
            value: initvalue,
            min: 0,
            max: 1,
            activeColor: AppColors.primary,
            inactiveColor: AppColors.greyLight,
            thumbColor: AppColors.primary,
            onChanged: (value) {
              setState(
                () {
                  initvalue = value;
                },
              );
            },
          ),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('🥶', style: TextStyle(fontSize: 16)),
            Text('🌶️', style: TextStyle(fontSize: 16)),
          ],
        )
      ],
    );
  }
}
