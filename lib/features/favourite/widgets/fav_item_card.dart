import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foods_app/core/helper/spacing.dart';
import 'package:foods_app/features/favourite/widgets/fav_remove_button.dart';
import 'package:foods_app/features/favourite/widgets/product_image.dart';
import 'package:foods_app/features/favourite/widgets/product_info.dart';
import 'package:foods_app/features/home/data/model/home_product_model.dart';

class FavItemCard extends StatelessWidget {
  final Product product;

  const FavItemCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            ProductImage(image: product.image),
            horizontalSpace(12.w),
            Expanded(child: ProductInfo(product: product)),
            FavRemoveButton(productId: product.id),
          ],
        ),
      ),
    );
  }
}
