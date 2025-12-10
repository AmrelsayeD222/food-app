import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/helper/text_style.dart';

class CheckBox extends StatefulWidget {
  const CheckBox({
    super.key,
  });

  @override
  State<CheckBox> createState() => _CheckBoxState();
}

bool isChecked = false;

class _CheckBoxState extends State<CheckBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          splashRadius: 0,
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value!;
            });
          },
          activeColor: AppColors.red,
        ),
        Text(
          'Save card details for future payments',
          style: TextStyles.textStyle14.copyWith(
            color: AppColors.grey,
          ),
        )
      ],
    );
  }
}
