import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import 'item_count.dart';
import 'item_disciption.dart';

class CartCardItem extends StatelessWidget {
  const CartCardItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Card(
      elevation: 5,
      color: AppColors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ItemDisciption(),
          ItemCount(),
        ],
      ),
    );
  }
}
