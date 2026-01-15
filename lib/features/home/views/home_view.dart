import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/core/helper/spacing.dart';
import 'package:foods_app/features/favourite/data/manager/fav/fav_cubit.dart';

import '../widgets/home_appbar.dart';
import '../widgets/home_card_field.dart';
import '../widgets/home_categoy_list.dart';
import '../widgets/search_field.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            BlocListener<FavCubit, FavState>(
              listener: (context, state) {
                if (state is FavSuccess) {
                } else if (state is FavError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const HomeCardBuilder(),
            ),
          ],
        ),
      ),
    );
  }
}
