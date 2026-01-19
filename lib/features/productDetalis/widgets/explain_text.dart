import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/helper/text_style.dart';

class ExplainText extends StatelessWidget {
  const ExplainText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'Customize ',
        style: TextStyles.textStyle16.copyWith(
          color: AppColors.black,
        ),
        children: [
          TextSpan(
              text: 'Your Burger \nTo Your Tast.Ultimate \nExperience',
              style: TextStyles.textStyle14),
        ],
      ),
    );
  }
}
