import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foods_app/core/helper/spacing.dart';

import '../../../core/helper/text_style.dart';
import '../../../core/shared/custom_bottom.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    super.key,
    required this.bottomText,
    required this.price,
    this.onpressed,
    required this.sheetText,
  });
  final String bottomText;
  final String price;
  final Function()? onpressed;
  final String sheetText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
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
              Text(
                sheetText,
                style: TextStyles.textStyle15,
              ),
              verticalSpace(5.h),
              Text(
                price,
                style: TextStyles.textStyle25,
              )
            ],
          ),
          CustomBottom(
            text: bottomText,
            onPressed: onpressed,
          )
        ],
      ),
    );
  }
}
