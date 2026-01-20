import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/helper/spacing.dart';
import 'topping_item.dart';

class ListviewToppingBuilder extends StatefulWidget {
  final ValueChanged<List<int>>? onSelectionChanged;

  const ListviewToppingBuilder({super.key, this.onSelectionChanged});

  @override
  State<ListviewToppingBuilder> createState() => _ListviewToppingBuilderState();
}

class _ListviewToppingBuilderState extends State<ListviewToppingBuilder> {
  final List<Map> toppingList = const [
    {'id': 1, 'name': 'Tomato', 'image': 'assets/detalis/tomato.png'},
    {'id': 2, 'name': 'Bacons', 'image': 'assets/detalis/Bacons.png'},
    {'id': 3, 'name': 'Pickles', 'image': 'assets/detalis/Pickles.png'},
    {'id': 4, 'name': 'Onions', 'image': 'assets/detalis/Onions.png'},
  ];

  final Set<int> selectedIds = {};

  void _toggleSelection(int id) {
    setState(() {
      if (selectedIds.contains(id)) {
        selectedIds.remove(id);
      } else {
        selectedIds.add(id);
      }
    });
    widget.onSelectionChanged?.call(selectedIds.toList());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) => horizontalSpace(10.w),
        itemCount: toppingList.length,
        itemBuilder: (context, index) {
          final topping = toppingList[index];
          final isSelected = selectedIds.contains(topping['id']);
          return GestureDetector(
            onTap: () => _toggleSelection(topping['id'] as int),
            child: ToppingItem(
              itemName: topping['name'] as String,
              itemImage: topping['image'] as String,
              color: isSelected ? AppColors.primary : AppColors.brown,
            ),
          );
        },
      ),
    );
  }
}
