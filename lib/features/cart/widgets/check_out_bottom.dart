import 'package:flutter/material.dart';
import 'package:foods_app/core/constants/app_colors.dart';
import 'package:foods_app/core/helper/navigation_extentions.dart';
import 'package:foods_app/core/helper/text_style.dart';
import 'package:foods_app/core/routes/app_routes.dart';
import 'package:foods_app/features/cart/data/model/cart_response_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget checkoutBottomSheet(BuildContext context, List<CartItem> items) {
  final totalPrice = items.fold(
    0.0,
    (sum, item) => sum + (item.price * item.quantity),
  );

  return SafeArea(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      color: AppColors.greyLight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: TextStyles.textStyle20.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$${totalPrice.toStringAsFixed(2)}',
                style: TextStyles.textStyle20.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          ElevatedButton(
            onPressed: items.isEmpty
                ? null
                : () {
                    context.pushNamed(
                      AppRoutes.checkoutView,
                      arguments: items,
                    );
                  },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50.h),
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Text(
              'Checkout',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
