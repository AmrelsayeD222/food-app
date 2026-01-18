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
      borderRadius: BorderRadius.circular(10.r),
      child: imageUrl != null && imageUrl!.isNotEmpty
          ? Image.network(
              imageUrl!,
              width: 150.w,
              height: 150.h,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return _placeholder();
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return SizedBox(
                    width: 150.w,
                    height: 150.h,
                    child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2.w)));
              },
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
