import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foods_app/core/helper/spacing.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/helper/text_style.dart';

class ToppingItem extends StatelessWidget {
  const ToppingItem({
    super.key,
    required this.itemName,
    required this.itemImage,
    required this.color,
  });
  final String itemName;
  final String itemImage;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(22.r),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 100.w,
            height: 90.h,
            decoration: BoxDecoration(
              color: AppColors.white,
              image: DecorationImage(
                alignment: Alignment.center,
                fit: BoxFit.fill,
                image: AssetImage(itemImage),
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(22.r),
              ),
            ),
          ),
          verticalSpace(10.h),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(22.r),
                bottomRight: Radius.circular(22.r),
              ),
            ),
            child: Text(
              itemName,
              style: TextStyles.textStyle12,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
