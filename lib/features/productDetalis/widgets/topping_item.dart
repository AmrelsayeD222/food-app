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
      width: MediaQuery.of(context).size.width * 0.25,
      height: MediaQuery.of(context).size.height * 0.30,
      decoration: const BoxDecoration(
        color: AppColors.brown,
        borderRadius: BorderRadius.all(
          Radius.circular(22),
        ),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.25,
        height: MediaQuery.of(context).size.height * 0.30,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.height * 0.11,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(22),
                ),
              ),
              child: Image.asset(
                fit: BoxFit.fill,
                itemImage,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
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
            ),
          ],
        ),
      ),
    );
  }
}
