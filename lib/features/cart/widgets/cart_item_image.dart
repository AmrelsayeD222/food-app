import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItemImage extends StatelessWidget {
  final String image;

  const CartItemImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: CachedNetworkImage(
        imageUrl: image,
        width: 100.w,
        height: 100.h,
        fit: BoxFit.fill,
        errorWidget: (_, __, ___) => _placeholder(),
      ),
    );
  }

  Widget _placeholder({bool isLoading = false}) {
    return Container(
      width: 100.w,
      height: 100.h,
      color: Colors.grey[200],
      child: Center(
        child: isLoading
            ? const CircularProgressIndicator(strokeWidth: 2)
            : const Icon(Icons.image_not_supported),
      ),
    );
  }
}
