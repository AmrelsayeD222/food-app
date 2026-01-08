import 'package:flutter/material.dart';
import 'package:foods_app/core/constants/app_colors.dart';
import 'package:foods_app/core/constants/constants.dart';
import 'package:foods_app/core/helper/navigation_extentions.dart';
import 'package:foods_app/core/helper/spacing.dart';
import 'package:foods_app/core/helper/text_style.dart';
import 'package:foods_app/core/routes/app_routes.dart';
import 'package:foods_app/core/shared/custom_bottom_sheet.dart';
import 'package:foods_app/features/cart/data/model/cart_response_model.dart';
import 'package:foods_app/features/checkout/widgets/check_box.dart';
import 'package:foods_app/features/checkout/widgets/custom_cash_list_tile.dart';
import 'package:foods_app/features/checkout/widgets/custom_detalis_row.dart';
import 'package:foods_app/features/checkout/widgets/custom_visa_list_tile.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key, required this.item});
  final CartItem item;

  final double tax = 10.0;
  final double deliveryFees = 0.2;

  @override
  Widget build(BuildContext context) {
    double orderPrice = item.price * item.quantity;

    double totalPrice = orderPrice + tax + deliveryFees;

    return ValueListenableBuilder(
      valueListenable: selectedPaymentNotifier,
      builder: (context, selectedPayment, _) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.white,
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
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Order summary', style: TextStyles.textStyle20),
                verticalSpace(10),
                CustomDetalisRow(
                  text: 'Order',
                  price: '\$${orderPrice.toStringAsFixed(2)}',
                  style: TextStyles.textStyle16,
                ),
                verticalSpace(5),
                CustomDetalisRow(
                  text: 'Tax',
                  price: '\$${tax.toStringAsFixed(2)}',
                  style: TextStyles.textStyle16,
                ),
                verticalSpace(5),
                CustomDetalisRow(
                  text: 'Delivery fees',
                  price: '\$${deliveryFees.toStringAsFixed(2)}',
                  style: TextStyles.textStyle16,
                ),
                const Divider(height: 20),
                CustomDetalisRow(
                  text: 'Total',
                  price: '\$${totalPrice.toStringAsFixed(2)}',
                  style: TextStyles.textStyle20,
                  padding: EdgeInsets.zero,
                ),
                verticalSpace(10),
                const CustomDetalisRow(
                  text: 'Estimated delivery time:',
                  price: '15 - 30 mins',
                  style: TextStyles.textStyle14,
                ),
                verticalSpace(30),
                const Text('Payment methods', style: TextStyles.textStyle20),
                verticalSpace(20),
                Column(
                  children: [
                    CustomCashListTile(
                      isSelected: selectedPayment == 'cash',
                      onTap: () => selectedPaymentNotifier.value = 'cash',
                    ),
                    const SizedBox(height: 20),
                    CustomVisaListTile(
                      isSelected: selectedPayment == 'visa',
                      onTap: () => selectedPaymentNotifier.value = 'visa',
                    ),
                  ],
                ),
                verticalSpace(20),
                const CheckBox(),
              ],
            ),
          ),
        );
      },
    );
  }
}
