import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/helper/spacing.dart';
import 'topping_item.dart';

class ListviewSideOptionBuilder extends StatefulWidget {
  final ValueChanged<List<int>>? onSelectionChanged;

  const ListviewSideOptionBuilder({
    super.key,
    this.onSelectionChanged,
  });

  @override
  State<ListviewSideOptionBuilder> createState() =>
      _ListviewSideOptionBuilderState();
}

class _ListviewSideOptionBuilderState extends State<ListviewSideOptionBuilder> {
  final List<Map<String, dynamic>> sideOptionList = const [
    {'id': 1, 'name': 'Onion', 'image': 'assets/detalis/Onion.png'},
    {'id': 2, 'name': 'Salad', 'image': 'assets/detalis/Salad.png'},
    {'id': 3, 'name': 'Coleslaw', 'image': 'assets/detalis/Coleslow.png'},
    {'id': 4, 'name': 'Fries', 'image': 'assets/detalis/Fries.png'},
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
        separatorBuilder: (_, __) => horizontalSpace(10),
        itemCount: sideOptionList.length,
        itemBuilder: (context, index) {
          final option = sideOptionList[index];
          final isSelected = selectedIds.contains(option['id'] as int);
          return GestureDetector(
            onTap: () => _toggleSelection(option['id'] as int),
            child: ToppingItem(
              itemName: option['name'] as String,
              itemImage: option['image'] as String,
              color: isSelected ? AppColors.primary : AppColors.brown,
            ),
          );
        },
      ),
    );
  }
}
