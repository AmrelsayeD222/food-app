import 'package:flutter/material.dart';
import 'package:foods_app/core/shared/custom_bottom_sheet.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/constants.dart';
import '../../../core/helper/spacing.dart';
import '../../../core/helper/text_style.dart';
import '../widgets/check_box.dart';
import '../widgets/custom_detalis_row.dart';
import '../widgets/custom_cash_list_tile.dart';
import '../widgets/custom_payment_widget.dart';
import '../widgets/custom_visa_list_tile.dart';
import '../widgets/success_dialog.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPaymentNotifier,
      builder: (context, selectedPayment, _) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            surfaceTintColor: Colors.transparent,
            backgroundColor: AppColors.white,
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          bottomSheet: CustomBottomSheet(
            onpressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SuccessDialog()));
            },
            text: 'Pay now',
            price: '\$20.00',
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Order summary', style: TextStyles.textStyle20),
                const CustomPaymetWidget(),
                const CustomDetalisRow(
                  text: 'Total',
                  price: '\$20.00',
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
                CustomCashListTile(
                  groupValue: selectedPayment,
                  onChanged: (v) => selectedPaymentNotifier.value = v!,
                ),
                verticalSpace(20),
                CustomVisaListTile(
                  groupValue: selectedPayment,
                  onChanged: (v) => selectedPaymentNotifier.value = v!,
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
