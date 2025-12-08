import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/helper/spacing.dart';
import '../../../core/helper/text_style.dart';

class ItemCount extends StatefulWidget {
  const ItemCount({
    super.key,
  });

  @override
  State<ItemCount> createState() => _ItemCountState();
}

class _ItemCountState extends State<ItemCount> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            IconButton(
                style: IconButton.styleFrom(
                    foregroundColor: AppColors.white,
                    backgroundColor: AppColors.primary),
                onPressed: () {
                  setState(() {
                    if (count > 1) {
                      count--;
                    }
                  });
                },
                icon: const Icon(Icons.remove)),
            horizontalSpace(10),
            SizedBox(
              height: 30,
              width: 30,
              child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(count.toString(), style: TextStyles.textStyle16)),
            ),
            horizontalSpace(10),
            IconButton(
                style: IconButton.styleFrom(
                    foregroundColor: AppColors.white,
                    backgroundColor: AppColors.primary),
                onPressed: () {
                  setState(() {
                    count++;
                  });
                },
                icon: const Icon(Icons.add))
          ],
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(150, 40),
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white),
          onPressed: () {
            setState(() {
              count = 1;
            });
          },
          child: const Text(
            'Remove',
          ),
        )
      ],
    );
  }
}
