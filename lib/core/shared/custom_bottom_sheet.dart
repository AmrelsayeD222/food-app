import 'package:flutter/material.dart';

import '../../../core/helper/text_style.dart';
import '../../../core/shared/custom_bottom.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    super.key,
    required this.text,
    required this.price,
    this.onpressed,
  });
  final String text;
  final String price;
  final Function()? onpressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Total', style: TextStyles.textStyle18),
              Text(price, style: TextStyles.textStyle32)
            ],
          ),
          CustomBottom(
            text: text,
            onPressed: onpressed,
          )
        ],
      ),
    );
  }
}
