import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/helper/text_style.dart';

class CustomAddBottom extends StatelessWidget {
  const CustomAddBottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Total', style: TextStyles.textStyle18),
          Text("\$18.19", style: TextStyles.textStyle32)
        ],
      ),
      ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          minimumSize: const Size(200, 70),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Text('Add To Cart'),
      )
    ]);
  }
}
