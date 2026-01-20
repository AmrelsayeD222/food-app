import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              icon: Icon(Icons.remove, size: 24.sp),
            ),
            horizontalSpace(10.w),
            SizedBox(
              height: 30.h,
              width: 30.w,
              child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(count.toString(), style: TextStyles.textStyle16)),
            ),
            horizontalSpace(10.w),
            IconButton(
              style: IconButton.styleFrom(
                  foregroundColor: AppColors.white,
                  backgroundColor: AppColors.primary),
              onPressed: () {
                _updateCount(count + 1);
              },
              icon: Icon(Icons.add, size: 24.sp),
            ),
          ],
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: Size(150.w, 40.h),
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
