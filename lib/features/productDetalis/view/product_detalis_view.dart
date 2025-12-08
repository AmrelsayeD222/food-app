import 'package:flutter/material.dart';
import 'package:foods_app/core/constants/app_colors.dart';
import 'package:foods_app/core/helper/spacing.dart';

import '../../../core/helper/text_style.dart';
import '../../cart/widgets/custom_cart_bottom.dart';
import '../widgets/custom_slider.dart';
import '../widgets/explain_text.dart';
import '../widgets/item_detalied_image.dart';
import '../widgets/listView_side_option_builder.dart';
import '../widgets/listView_topping_builder.dart';

class ProductDetalisView extends StatelessWidget {
  const ProductDetalisView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.white,
        leading:
            IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ItemDetaliedImage(),
                SizedBox(
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ExplainText(),
                      CustomSlider(),
                    ],
                  ),
                ),
              ],
            ),
            verticalSpace(10),
            const Text('Toppings', style: TextStyles.textStyle18),
            verticalSpace(20),
            const ListviewToppingBuilder(),
            verticalSpace(20),
            const Text('Side Options', style: TextStyles.textStyle18),
            const ListviewSideOptionBuilder(),
            verticalSpace(20),
            const CustomCartBottom(
              text: 'Add to cart',
              price: '\$18.19',
            ),
            verticalSpace(20),
          ]),
        ),
      ),
    );
  }
}
