import 'package:flutter/material.dart';
import 'package:foods_app/core/constants/app_colors.dart';
import 'package:foods_app/core/helper/navigation_extentions.dart';
import 'package:foods_app/core/routes/app_routes.dart';
import 'package:foods_app/features/home/data/model/home_product_model.dart';
import 'package:foods_app/features/home/widgets/fav_icon.dart';

import '../../../../core/helper/text_style.dart';

class HomeCard extends StatelessWidget {
  final Product product;
  final String token;

  const HomeCard({
    super.key,
    required this.product,
    required this.token,
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
              FavIcon(
                productId: product.id,
                token: token,
              ),
              GestureDetector(
                onTap: () {
                  context.pushNamed(
                    AppRoutes.productDetalisView,
                    arguments: product,
                  );
                },
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    Image.network(
                      height: 105,
                      product.image,
                      fit: BoxFit.fill,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.image_not_supported),
                    ),
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
            ],
          ),
        ),
      ),
    );
  }
}
