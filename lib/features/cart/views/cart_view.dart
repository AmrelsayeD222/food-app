import 'package:flutter/material.dart';
import 'package:foods_app/core/helper/spacing.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/helper/text_style.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          verticalSpace(30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
              child: Card(
                elevation: 5,
                color: AppColors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Image.asset('assets/splash/splash_image.png',
                            height: 150, width: 150),
                        Text("Hamburger\nVeggie Burger",
                            style: TextStyles.textStyle16
                                .copyWith(color: AppColors.black))
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            IconButton(
                                style: IconButton.styleFrom(
                                    foregroundColor: AppColors.white,
                                    backgroundColor: AppColors.primary),
                                onPressed: () {},
                                icon: const Icon(Icons.add)),
                            horizontalSpace(10),
                            const Text("1", style: TextStyles.textStyle16),
                            horizontalSpace(10),
                            IconButton(
                                style: IconButton.styleFrom(
                                    foregroundColor: AppColors.white,
                                    backgroundColor: AppColors.primary),
                                onPressed: () {},
                                icon: const Icon(Icons.remove))
                          ],
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(150, 40),
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.white),
                          onPressed: () {},
                          child: const Text(
                            'Remove',
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
