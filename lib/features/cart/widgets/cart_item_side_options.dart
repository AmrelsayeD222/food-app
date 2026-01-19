import 'package:flutter/material.dart';
import 'package:foods_app/core/helper/text_style.dart';
import 'package:foods_app/features/cart/data/model/cart_response_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'cart_option_chip.dart';

class CartItemSideOptions extends StatelessWidget {
  final List<CartOption> options;

  const CartItemSideOptions({
    super.key,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12.h),
        const Divider(height: 1),
        SizedBox(height: 12.h),
        Row(
          children: [
            Icon(Icons.dining, size: 18.sp),
            SizedBox(width: 6.w),
            Text(
              'Side Options',
              style:
                  TextStyles.textStyle14.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: options.map((e) => CartOptionChip(option: e)).toList(),
        ),
      ],
    );
  }
}
