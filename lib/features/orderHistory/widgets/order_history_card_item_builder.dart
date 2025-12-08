import 'package:flutter/material.dart';

import 'order_history_card_item.dart';

class OrderHistoryCardItemBuilder extends StatelessWidget {
  const OrderHistoryCardItemBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 10),
      itemBuilder: (context, index) {
        return const OrderHistoryCardItem();
      },
      itemCount: 12,
    );
  }
}
