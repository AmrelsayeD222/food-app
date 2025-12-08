import 'package:flutter/material.dart';
import 'package:foods_app/core/constants/app_colors.dart';

import '../widgets/order_history_card_item_builder.dart';

class OrderHistoryView extends StatelessWidget {
  const OrderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10,
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: const OrderHistoryCardItemBuilder(),
    );
  }
}
