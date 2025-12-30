import 'package:flutter/material.dart';
import 'package:foods_app/core/helper/spacing.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/helper/text_style.dart';

class ToppingItem extends StatelessWidget {
  const ToppingItem({
    super.key,
    required this.itemName,
    required this.itemImage,
    required this.color,
  });
  final String itemName;
  final String itemImage;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(22),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 110,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.white,
              image: DecorationImage(
                alignment: Alignment.center,
                fit: BoxFit.fill,
                image: AssetImage(itemImage),
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(22),
              ),
            ),
          ),
          verticalSpace(10),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(22),
                bottomRight: Radius.circular(22),
              ),
            ),
            child: Text(
              itemName,
              style: TextStyles.textStyle12,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
