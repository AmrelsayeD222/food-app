import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductImage extends StatelessWidget {
  final String image;

  const ProductImage({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: CachedNetworkImage(
        imageUrl: image,
        width: 100.w,
        height: 100.h,
        fit: BoxFit.fill,
        errorWidget: (context, url, error) => Container(
          width: 100.w,
          height: 100.h,
          color: Colors.grey.shade300,
          child: Icon(
            Icons.image_not_supported,
            color: Colors.grey,
            size: 30.sp,
          ),
        ),
      ),
    );
  }
}
