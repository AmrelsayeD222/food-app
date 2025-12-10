import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/helper/text_style.dart';
import 'custom_radio_widget.dart';

class CustomVisaListTile extends StatelessWidget {
  const CustomVisaListTile({
    super.key,
    required this.groupValue,
    required this.onChanged,
  });

  final String groupValue;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 80,
      tileColor: AppColors.greyLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      leading: Image.asset(
        'assets/detalis/visa.png',
        width: 60,
        fit: BoxFit.fill,
      ),
      title: const Text('Debit card', style: TextStyles.textStyle14),
      subtitle:
          const Text('3566 **** **** 0505', style: TextStyles.textStyle14),
      trailing: CustomRadioWidget(
        value: 'visa',
        groupValue: groupValue,
        onChanged: onChanged,
      ),
    );
  }
}
