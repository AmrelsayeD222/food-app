import 'package:flutter/material.dart';
import 'package:foods_app/features/cart/data/model/cart_response_model.dart';
import '../../../core/constants/app_colors.dart';
import 'item_disciption.dart';

class CartCardItem extends StatelessWidget {
  final CartItem item;

  const CartCardItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: AppColors.white,
      child: ItemDescription(item: item),
    );
  }
}
