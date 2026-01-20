import 'package:flutter/material.dart';
import 'package:foods_app/core/constants/app_colors.dart';

class FavLoading extends StatelessWidget {
  const FavLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.primary,
      ),
    );
  }
}
