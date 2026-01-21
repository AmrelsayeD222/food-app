import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foods_app/core/constants/app_colors.dart';
import 'package:foods_app/core/constants/constants.dart';
import 'package:foods_app/core/helper/navigation_extentions.dart';
import 'package:foods_app/core/helper/spacing.dart';
import 'package:foods_app/core/helper/text_style.dart';
import 'package:foods_app/core/routes/app_routes.dart';
import 'package:foods_app/core/shared/custom_bottom_sheet.dart';
import 'package:foods_app/features/cart/data/model/cart_response_model.dart';
import 'package:foods_app/features/checkout/widgets/custom_cash_list_tile.dart';
import 'package:foods_app/features/checkout/widgets/custom_detalis_row.dart';
import 'package:foods_app/features/checkout/widgets/custom_visa_list_tile.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key, required this.items});
  final List<CartItem> items;

  final double tax = 10.0;
  final double deliveryFees = 0.2;

  @override
  Widget build(BuildContext context) {
    final orderPrice = items.fold(
      0.0,
      (sum, item) => sum + (item.price * item.quantity),
    );

    final totalPrice = orderPrice + tax + deliveryFees;

    return ValueListenableBuilder(
      valueListenable: selectedPaymentNotifier,
      builder: (context, selectedPayment, _) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          bottomSheet: CustomBottomSheet(
            sheetText: 'Total',
            onpressed: () {
              context.pushNamed(AppRoutes.successDialog);
            },
            bottomText: 'Pay now',
            price: '\$${totalPrice.toStringAsFixed(2)}',
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Gradient Header Section
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.08),
                        Colors.white,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Summary',
                        style: TextStyles.textStyle20.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.sp,
                        ),
                      ),
                      verticalSpace(16.h),

                      // Order Summary Card
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.06),
                              blurRadius: 12.r,
                              offset: Offset(0, 4.h),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            CustomDetalisRow(
                              text: 'Order',
                              price: '\$${orderPrice.toStringAsFixed(2)}',
                              style: TextStyles.textStyle16,
                            ),
                            verticalSpace(12.h),
                            CustomDetalisRow(
                              text: 'Tax',
                              price: '\$${tax.toStringAsFixed(2)}',
                              style: TextStyles.textStyle16,
                            ),
                            verticalSpace(12.h),
                            CustomDetalisRow(
                              text: 'Delivery fees',
                              price: '\$${deliveryFees.toStringAsFixed(2)}',
                              style: TextStyles.textStyle16,
                            ),
                            Divider(height: 24.h, thickness: 1),
                            CustomDetalisRow(
                              text: 'Total',
                              price: '\$${totalPrice.toStringAsFixed(2)}',
                              style: TextStyles.textStyle20.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              padding: EdgeInsets.zero,
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(12.h),

                      // Delivery Time Info
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 18.sp,
                            color: AppColors.primary,
                          ),
                          horizontalSpace(8.w),
                          Text(
                            'Estimated delivery: 15 - 30 mins',
                            style: TextStyles.textStyle14.copyWith(
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Payment Methods Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(24.h),
                      Text(
                        'Payment Method',
                        style: TextStyles.textStyle20.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),
                      verticalSpace(16.h),
                      CustomCashListTile(
                        isSelected: selectedPayment == 'cash',
                        onTap: () => selectedPaymentNotifier.value = 'cash',
                      ),
                      verticalSpace(12.h),
                      CustomVisaListTile(
                        isSelected: selectedPayment == 'visa',
                        onTap: () => selectedPaymentNotifier.value = 'visa',
                      ),
                      verticalSpace(20.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
