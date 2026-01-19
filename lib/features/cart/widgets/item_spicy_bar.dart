import 'package:flutter/material.dart';
import 'package:foods_app/core/helper/text_style.dart';
import 'package:foods_app/features/cart/data/model/cart_response_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemSpicyBar extends StatelessWidget {
  const ItemSpicyBar({
    super.key,
    required this.item,
  });

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.local_fire_department, color: Colors.red, size: 20.sp),
        SizedBox(width: 6.w),
        Text(
          'Spicy Level:',
          style: TextStyles.textStyle14.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(width: 8.w),
        ...List.generate(
          5,
          (index) {
            double spicyLevel = item.spicy * 5;
            return Icon(
              Icons.local_fire_department,
              size: 24.sp,
              color: index < spicyLevel ? Colors.red : Colors.grey[300],
            );
          },
        ),
      ],
    );
  }
}
