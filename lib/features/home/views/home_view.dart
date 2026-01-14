import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:foods_app/core/helper/spacing.dart';
import 'package:foods_app/features/favourite/data/manager/Get/get_cubit.dart';
import 'package:foods_app/features/favourite/data/manager/AddAndRemove/add_and_remove_cubit.dart';
import '../widgets/home_appbar.dart';
import '../widgets/home_card_field.dart';
import '../widgets/home_categoy_list.dart';
import '../widgets/search_field.dart';

class HomeView extends StatelessWidget {
  final String token;

  const HomeView({super.key, required this.token});

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
            MultiBlocListener(
              listeners: [
                BlocListener<AddCubit, AddState>(
                  listener: (context, state) {
                    if (state is AddSuccess) {
                      print(
                          '✨ LOG: HomeView received AddSuccess. Refreshing GetFavCubit...');
                      context
                          .read<GetFavCubit>()
                          .getFavorites(token, isLoading: false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Item added to Favourits"),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else if (state is AddFailure) {
                      print(
                          '⚠️ LOG: HomeView received AddFailure: ${state.error}');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.error)),
                      );
                    }
                  },
                ),
                BlocListener<RemoveCubit, RemoveState>(
                  listener: (context, state) {
                    if (state is RemoveSuccess) {
                      print(
                          '🗑️ LOG: HomeView received RemoveSuccess. Refreshing GetFavCubit...');
                      context
                          .read<GetFavCubit>()
                          .getFavorites(token, isLoading: false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Item removed from Favourits"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else if (state is RemoveFailure) {
                      print(
                          '⚠️ LOG: HomeView received RemoveFailure: ${state.error}');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.error)),
                      );
                    }
                  },
                ),
                BlocListener<GetFavCubit, GetFavState>(
                  listener: (context, state) {
                    if (state is GetFavFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.error)),
                      );
                    }
                  },
                ),
              ],
              child: HomeCardBuilder(token: token),
            ),
          ],
        ),
      ),
    );
  }
}
