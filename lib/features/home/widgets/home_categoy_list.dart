import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/helper/spacing.dart';
import 'category_bottom.dart';

class HomeCategoyList extends StatefulWidget {
  const HomeCategoyList({super.key});

  @override
  State<HomeCategoyList> createState() => _HomeCategoyListState();
}

class _HomeCategoyListState extends State<HomeCategoyList> {
  final List<String> title = const [
    'All',
    'Burger',
    'Pizza',
    'Salad',
    'Drinks',
    'Dessert',
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: ListView.separated(
        separatorBuilder: (context, index) => horizontalSpace(12.w),
        scrollDirection: Axis.horizontal,
        itemCount: title.length,
        itemBuilder: (context, index) {
          return CategoryBottm(
            backgroundColor: index == selectedIndex
                ? AppColors.primary
                : AppColors.greyLight,
            foregroundColor:
                index == selectedIndex ? AppColors.white : AppColors.grey,
            text: title[index],
            onPressed: () {
              setState(
                () {
                  selectedIndex = index;
                },
              );
            },
          );
        },
      ),
    );
  }
}
