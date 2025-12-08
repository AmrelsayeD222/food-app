import 'package:flutter/material.dart';
import 'package:foods_app/core/helper/spacing.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/helper/text_style.dart';
import '../../../core/shared/custom_bottom.dart';

class OrderHistoryCardItem extends StatelessWidget {
  const OrderHistoryCardItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, left: 8),
      child: SizedBox(
        height: 220,
        child: Card(
          elevation: 5,
          color: AppColors.white,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    'assets/splash/splash_image.png',
                    width: 150,
                    height: 120,
                    fit: BoxFit.fill,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hambuger Hambuger',
                        style: TextStyles.textStyle16.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text('Quantity : 000',
                          style: TextStyles.textStyle16),
                      const Text('Price : 000', style: TextStyles.textStyle16),
                    ],
                  )
                ],
              ),
              verticalSpace(20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomBottom(
                  backgroundColor: AppColors.grey,
                  foregroundColor: AppColors.white,
                  text: 'Order Again',
                  height: 60,
                  width: double.infinity,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
