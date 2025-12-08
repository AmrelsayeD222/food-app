import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/helper/text_style.dart';

class ToppingItem extends StatelessWidget {
  const ToppingItem({
    super.key,
    required this.itemName,
    required this.itemImage,
    required this.bottomColor,
  });
  final String itemName;
  final String itemImage;
  final Color bottomColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 150,
      decoration: const BoxDecoration(
        color: AppColors.brown,
        borderRadius: BorderRadius.all(
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
          Container(
            decoration: const BoxDecoration(
              color: AppColors.brown,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(22),
                bottomRight: Radius.circular(22),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    textAlign: TextAlign.center,
                    itemName,
                    style: TextStyles.textStyle12,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  style: IconButton.styleFrom(
                    foregroundColor: AppColors.white,
                    iconSize: 18,
                    minimumSize: const Size(15, 15),
                    padding: const EdgeInsets.all(2),
                    backgroundColor: bottomColor,
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
