import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/helper/text_style.dart';

class ItemDisciption extends StatelessWidget {
  const ItemDisciption({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/splash/splash_image.png',
          width: 150,
          height: 120,
          fit: BoxFit.fill,
        ),
        Text("Hamburger",
            style: TextStyles.textStyle16
                .copyWith(color: AppColors.black, fontWeight: FontWeight.bold)),
        Text("Veggie Burger",
            style: TextStyles.textStyle16.copyWith(color: AppColors.black))
      ],
    );
  }
}
