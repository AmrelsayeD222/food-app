import 'package:flutter/material.dart';
import 'package:foods_app/features/cart/data/model/cart_response_model.dart';
import 'cart_card_item.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartCardItemBuilder extends StatelessWidget {
  final List<CartItem> items;

  const CartCardItemBuilder({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 10.h, left: 8.w, right: 8.w, top: 10.h),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return CartCardItem(item: items[index]);
      },
    );
  }
}
