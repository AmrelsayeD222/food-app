import 'package:flutter/material.dart';
import 'package:foods_app/features/cart/data/model/cart_response_model.dart';
import 'package:foods_app/features/cart/widgets/item_spicy_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItemSpicySection extends StatelessWidget {
  final CartItem item;

  const CartItemSpicySection({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12.h),
        const Divider(height: 1),
        SizedBox(height: 12.h),
        ItemSpicyBar(item: item),
      ],
    );
  }
}
