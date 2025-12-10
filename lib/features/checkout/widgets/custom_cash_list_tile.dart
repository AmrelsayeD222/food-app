import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/helper/text_style.dart';
import 'custom_radio_widget.dart';

class CustomCashListTile extends StatelessWidget {
  const CustomCashListTile({
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
      tileColor: AppColors.brown,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      leading: Image.asset(
        'assets/detalis/dollar_Background_Removed.png',
        fit: BoxFit.fill,
      ),
      title: Text(
        'Cash on Delivery',
        style: TextStyles.textStyle16.copyWith(color: AppColors.white),
      ),
      trailing: CustomRadioWidget(
        value: 'cash',
        groupValue: groupValue,
        onChanged: onChanged,
      ),
    );
  }
}
