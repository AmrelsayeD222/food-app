import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProfileImage extends StatelessWidget {
  final String? imageUrl;

  const CustomProfileImage({
    super.key,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100.r),
      child: imageUrl != null && imageUrl!.isNotEmpty
          ? CachedNetworkImage(
              imageUrl: imageUrl!,
              width: 150.w,
              height: 150.h,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => _placeholder(),
            )
          : _placeholder(),
    );
  }

  Widget _placeholder() {
    return Container(
      width: 150.w,
      height: 150.h,
      color: Colors.grey.shade200,
      alignment: Alignment.center,
      child: Icon(
        Icons.person,
        size: 40.sp,
        color: Colors.grey,
      ),
    );
  }
}
