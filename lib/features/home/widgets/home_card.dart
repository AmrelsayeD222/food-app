import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foods_app/core/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foods_app/core/helper/navigation_extentions.dart';
import 'package:foods_app/core/routes/app_routes.dart';
import 'package:foods_app/features/home/data/model/home_product_model.dart';
import 'package:foods_app/features/home/widgets/fav_icon.dart';

import '../../../../core/helper/text_style.dart';

class HomeCard extends StatelessWidget {
  final Product product;

  const HomeCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(8.r),
            child: GestureDetector(
              onTap: () {
                context.pushNamed(
                  AppRoutes.productDetalisView,
                  arguments: product,
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 5.h),
                  Hero(
                    tag: 'product_${product.id}',
                    child: CachedNetworkImage(
                      imageUrl: product.image,
                      height: 100.h,
                      fit: BoxFit.contain,
                      placeholder: (context, url) => SizedBox(
                        height: 100.h,
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.image_not_supported),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.textStyle16.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyles.textStyle14.copyWith(
                      height: 1.1,
                      color: Colors.grey,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "⭐ ${product.ratingAsDouble}",
                        style: TextStyles.textStyle14,
                      ),
                      Text(
                        "${product.priceAsDouble}\$",
                        style: TextStyles.textStyle14.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 4.r,
            right: 4.r,
            child: FavIcon(
              productId: product.id,
            ),
          ),
        ],
      ),
    );
  }
}
