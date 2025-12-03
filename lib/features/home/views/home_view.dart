import 'package:flutter/material.dart';
import 'package:foods_app/core/helper/spacing.dart';
import 'package:foods_app/features/home/views/widgets/home_card_field.dart';
import 'widgets/home_categoy_list.dart';
import 'widgets/home_appbar.dart';
import 'widgets/search_field.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    verticalSpace(50),
                    const HomeAppBar(),
                    verticalSpace(20),
                    const SearchField(),
                    verticalSpace(40),
                    const HomeCategoyList(),
                    verticalSpace(20),
                  ],
                ),
              ),
              const HomeCardBuilder(),
            ],
          ),
        ),
      ),
    );
  }
}
