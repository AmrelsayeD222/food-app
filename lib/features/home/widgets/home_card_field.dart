import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:foods_app/features/home/data/manager/cubit/home_product_cubit.dart';
import 'package:foods_app/features/home/widgets/home_card.dart';

class HomeCardBuilder extends StatelessWidget {
  const HomeCardBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeProductCubit, HomeProductState>(
      builder: (context, state) {
        if (state is HomeProductLoading) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is HomeProductError) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Text(state.message),
            ),
          );
        }
        if (state is HomeProductLoaded) {
          return SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: .75,
            ),
            delegate: SliverChildBuilderDelegate(
              childCount: state.products.length,
              (context, index) {
                final product = state.products[index];
                return HomeCard(
                  product: product,
                );
              },
            ),
          );
        }

        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
