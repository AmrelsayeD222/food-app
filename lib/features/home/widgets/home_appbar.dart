import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/helper/text_style.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/splash/splash_logo.svg',
              width: MediaQuery.of(context).size.width * 0.50,
              colorFilter:
                  const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
              fit: BoxFit.cover,
            ),
            const Text(
              'Hello,Mr Burger',
              style: TextStyles.textStyle16,
            ),
          ],
        ),
        const CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('assets/splash/splash_image.png'),
        ),
      ],
    );
  }
}
