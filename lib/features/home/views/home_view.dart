import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foods_app/core/helper/spacing.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/helper/text_style.dart';
import '../../../core/shared/category_bottom.dart';
import '../../../core/shared/custom_text_form_field.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                verticalSpace(50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/splash/splash_logo.svg',
                          width: MediaQuery.of(context).size.width * 0.50,
                          colorFilter: const ColorFilter.mode(
                              AppColors.primary, BlendMode.srcIn),
                          fit: BoxFit.cover,
                        ),
                        const Text(
                          'Hello,Mr Burger',
                          style: TextStyles.textStyle16,
                        ),
                      ],
                    ),
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          AssetImage('assets/splash/splash_image.png'),
                    ),
                  ],
                ),
                verticalSpace(20),
                const Material(
                  elevation: 4,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  child: CustomTextFormField(
                    hintText: 'Search..',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                verticalSpace(40),
                SizedBox(
                  height: 50,
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8),
                    scrollDirection: Axis.horizontal,
                    itemCount: title.length,
                    itemBuilder: (context, index) {
                      return CategoryBottm(
                        backgroundColor: index == selectedIndex
                            ? AppColors.primary
                            : AppColors.greyLight,
                        foregroundColor: index == selectedIndex
                            ? AppColors.white
                            : AppColors.grey,
                        text: title[index],
                        onPressed: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
