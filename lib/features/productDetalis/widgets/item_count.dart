import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/helper/spacing.dart';
import '../../../core/helper/text_style.dart';

class ItemCount extends StatefulWidget {
  final ValueChanged<int>? onQuantityChanged;
  const ItemCount({super.key, this.onQuantityChanged});

  @override
  State<ItemCount> createState() => _ItemCountState();
}

class _ItemCountState extends State<ItemCount> {
  int count = 1;

  void _updateCount(int val) {
    setState(() {
      count = val;
    });
    widget.onQuantityChanged?.call(count);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              style: IconButton.styleFrom(
                  foregroundColor: AppColors.white,
                  backgroundColor: AppColors.primary),
              onPressed: () {
                if (count > 1) _updateCount(count - 1);
              },
              icon: const Icon(Icons.remove),
            ),
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
                _updateCount(count + 1);
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(150, 40),
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white),
          onPressed: () {
            _updateCount(1); // reset
          },
          child: const Text('Remove'),
        )
      ],
    );
  }
}
