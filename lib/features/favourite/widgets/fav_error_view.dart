import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foods_app/core/helper/spacing.dart';

class FavErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const FavErrorView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 80.sp, color: Colors.red.shade300),
          verticalSpace(20.h),
          Text(
            'Error loading favourites',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
          ),
          verticalSpace(10.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.sp),
          ),
          verticalSpace(20.h),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: Icon(Icons.refresh, size: 20.sp),
            label: Text('Retry', style: TextStyle(fontSize: 14.sp)),
          ),
        ],
      ),
    );
  }
}
