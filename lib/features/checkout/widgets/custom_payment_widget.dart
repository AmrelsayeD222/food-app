import 'package:flutter/material.dart';
import 'package:foods_app/features/checkout/widgets/custom_detalis_row.dart';

import '../../../core/helper/spacing.dart';
import '../../../core/helper/text_style.dart';

class CustomPaymetWidget extends StatelessWidget {
  const CustomPaymetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpace(10),
        const CustomDetalisRow(
          text: 'Order',
          price: '\$18.19',
          style: TextStyles.textStyle16,
        ),
        verticalSpace(5),
        const CustomDetalisRow(
          text: 'Tax',
          price: '\$8.9',
          style: TextStyles.textStyle16,
        ),
        verticalSpace(5),
        const CustomDetalisRow(
          text: 'Delivery fees',
          price: '\$.19',
          style: TextStyles.textStyle16,
        ),
        verticalSpace(10),
      ],
    );
  }
}
