import 'package:flutter/material.dart';

import '../../../core/helper/text_style.dart';
import '../../../core/shared/custom_bottom.dart';

class CustomCartBottom extends StatelessWidget {
  const CustomCartBottom({
    super.key,
    required this.text,
    required this.price,
  });
  final String text;
  final String price;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Total', style: TextStyles.textStyle18),
            Text(price, style: TextStyles.textStyle32)
          ],
        ),
        const CustomBottom(
          text: 'CheckOut',
        )
      ],
    );
  }
}
