import 'package:flutter/material.dart';
import 'package:foods_app/core/constants/app_colors.dart';
import 'package:foods_app/features/home/data/model/home_product_model.dart';

import '../../../../core/helper/text_style.dart';

class HomeCard extends StatelessWidget {
  final Product product;
  const HomeCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 4,
      child: Card(
        color: AppColors.white,
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Image.network(
                  product.image,
                  fit: BoxFit.fill,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.image_not_supported),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                product.name,
                style: TextStyles.textStyle16.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                product.description,
                style: const TextStyle(
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 5),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("⭐ ${product.ratingAsDouble}")),
            ],
          ),
        ),
      ),
    );
  }
}
