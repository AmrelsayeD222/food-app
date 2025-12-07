import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/helper/text_style.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 4,
      child: Card(
        color: AppColors.white,
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Image(
                  image: AssetImage('assets/splash/burger1.png'),
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                'Cheeseburger',
                style: TextStyles.textStyle16.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              Text(
                "Wendy's Burger",
                style: TextStyles.textStyle16.copyWith(),
              ),
              const Text("⭐ 4.9"),
            ],
          ),
        ),
      ),
    );
  }
}
