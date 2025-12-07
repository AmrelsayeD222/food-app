import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/helper/spacing.dart';
import 'topping_item.dart';

class ListviewToppingBuilder extends StatefulWidget {
  const ListviewToppingBuilder({super.key});

  @override
  State<ListviewToppingBuilder> createState() => _ListviewToppingBuilderState();
}

class _ListviewToppingBuilderState extends State<ListviewToppingBuilder> {
  final List<Map> toppingList = const [
    {'name': 'Tomato', 'image': 'assets/detalis/tomato.png'},
    {'name': 'Bacons', 'image': 'assets/detalis/Bacons.png'},
    {'name': 'Pickles', 'image': 'assets/detalis/Pickles.png'},
    {'name': 'Onions', 'image': 'assets/detalis/Onions.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.separated(
        separatorBuilder: (context, index) => horizontalSpace(10),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => ToppingItem(
          itemName: toppingList[index]['name'],
          itemImage: toppingList[index]['image'],
          bottomColor: AppColors.red,
        ),
        itemCount: toppingList.length,
      ),
    );
  }
}
