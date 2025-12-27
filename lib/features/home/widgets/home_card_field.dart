import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/core/helper/navigation_extentions.dart';
import 'package:foods_app/core/routes/app_routes.dart';
import 'package:foods_app/features/home/data/manager/cubit/home_product_cubit.dart';
import 'package:foods_app/features/home/widgets/home_card.dart';

class HomeCardBuilder extends StatelessWidget {
  const HomeCardBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeProductCubit, HomeProductState>(
      builder: (context, state) {
        if (state is HomeProductLoading) {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is HomeProductError) {
          return SliverToBoxAdapter(
            child: Center(child: Text(state.message)),
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
                return GestureDetector(
                  onTap: () {
                    context.pushNamed(
                      AppRoutes.productDetalisView,
                      arguments: product,
                    );
                  },
                  child: HomeCard(product: product),
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
