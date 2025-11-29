import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constants/app_colors.dart';
import '../../core/helper/spacing.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        children: [
          verticalSpace(MediaQuery.of(context).size.height * 0.35),
          SvgPicture.asset('assets/splash/splash_logo.svg'),
          const Spacer(),
          Image.asset('assets/splash/splash_image.png')
        ],
      ),
    );
  }
}
