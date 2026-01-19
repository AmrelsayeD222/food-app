import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:foods_app/features/home/data/manager/cubit/home_product_cubit.dart';
import 'package:foods_app/features/home/data/model/home_product_model.dart';
import 'package:foods_app/features/home/widgets/home_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeCardBuilder extends StatelessWidget {
  const HomeCardBuilder({
    super.key,
  });

  List<Product> _getDummyProducts() {
    return List.generate(
      6,
      (index) => Product(
        id: index,
        name: 'Product Name',
        description: 'Product Description goes here in this field',
        image: '',
        rating: '4.5',
        price: '100.0',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeProductCubit, HomeProductState>(
      builder: (context, state) {
        if (state is HomeProductLoading) {
          return Skeletonizer.sliver(
            enabled: true,
            child: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12.h,
                crossAxisSpacing: 12.w,
                childAspectRatio: 0.7,
              ),
              delegate: SliverChildBuilderDelegate(
                childCount: 6,
                (context, index) {
                  return HomeCard(
                    product: _getDummyProducts()[index],
                  );
                },
              ),
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
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12.h,
              crossAxisSpacing: 12.w,
              childAspectRatio: 0.7,
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
