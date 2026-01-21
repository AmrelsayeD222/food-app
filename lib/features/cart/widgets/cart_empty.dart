import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foods_app/core/helper/spacing.dart';

class CartEmpty extends StatelessWidget {
  const CartEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart, size: 100.sp, color: Colors.grey.shade400),
          verticalSpace(20.h),
          Text(
            'No Cart items Yet',
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          verticalSpace(10.h),
          Text(
            'Start adding items to your cart!',
            style: TextStyle(fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
}
