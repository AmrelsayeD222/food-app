import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDetalisRow extends StatelessWidget {
  const CustomDetalisRow({
    super.key,
    required this.text,
    required this.price,
    this.style,
    this.padding,
  });
  final String text, price;
  final TextStyle? style;
  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: style,
          ),
          Text(
            price,
            style: style,
          ),
        ],
      ),
    );
  }
}
