import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/helper/spacing.dart';
import 'topping_item.dart';

class ListviewSideOptionBuilder extends StatefulWidget {
  const ListviewSideOptionBuilder({super.key});

  @override
  State<ListviewSideOptionBuilder> createState() =>
      _ListviewSideOptionBuilderState();
}

class _ListviewSideOptionBuilderState extends State<ListviewSideOptionBuilder> {
  final List<Map> sideOption = const [
    {'name': 'Onion', 'image': 'assets/detalis/Onion.png'},
    {'name': 'Salad', 'image': 'assets/detalis/Salad.png'},
    {'name': 'Coleslaw', 'image': 'assets/detalis/Coleslaw.png'},
    {'name': 'Fries', 'image': 'assets/detalis/Fries.png'},
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.separated(
        separatorBuilder: (context, index) => horizontalSpace(10),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => ToppingItem(
          itemName: sideOption[index]['name'],
          itemImage: sideOption[index]['image'],
          bottomColor: AppColors.green,
        ),
        itemCount: sideOption.length,
      ),
    );
  }
}
