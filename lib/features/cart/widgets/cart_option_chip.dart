import 'package:flutter/material.dart';
import 'package:foods_app/core/constants/app_colors.dart';
import 'package:foods_app/core/helper/text_style.dart';
import 'package:foods_app/features/cart/data/model/cart_response_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartOptionChip extends StatelessWidget {
  final CartOption option;

  const CartOptionChip({super.key, required this.option});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.black.withValues(alpha: .05),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (option.image.isNotEmpty)
            Image.network(option.image, width: 20.w, height: 20.h),
          if (option.image.isNotEmpty) SizedBox(width: 6.w),
          Text(option.name, style: TextStyles.textStyle14),
        ],
      ),
    );
  }
}
