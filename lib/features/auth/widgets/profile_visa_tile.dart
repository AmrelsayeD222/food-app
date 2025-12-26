import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/helper/text_style.dart';

class ProfileVisaTile extends StatelessWidget {
  final String? visa;

  const ProfileVisaTile({super.key, this.visa});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 80,
      tileColor: AppColors.greyLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      leading: Image.asset(
        'assets/detalis/visa.png',
        width: 60,
        fit: BoxFit.fill,
      ),
      title: const Text('Debit card', style: TextStyles.textStyle14),
      subtitle: Text(
        visa != null && visa!.isNotEmpty ? visa! : 'No Card',
        style: TextStyles.textStyle14,
      ),
      trailing: const Text(
        'Default',
        style: TextStyles.textStyle14,
      ),
    );
  }
}
