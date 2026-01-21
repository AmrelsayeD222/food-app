import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/core/constants/app_colors.dart';
import 'package:foods_app/features/favourite/data/manager/toggle/fav_cubit.dart';
import 'package:foods_app/features/favourite/widgets/fav_empty_view.dart';
import 'package:foods_app/features/favourite/widgets/fav_error_view.dart';
import 'package:foods_app/features/favourite/widgets/fav_list_view.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:foods_app/features/home/data/model/home_product_model.dart';

class FavourireView extends StatefulWidget {
  const FavourireView({super.key});

  @override
  State<FavourireView> createState() => _FavourireViewState();
}

class _FavourireViewState extends State<FavourireView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FavCubit>().loadFavorites();
    });
  }

  List<Product> _getDummyProducts() {
    return List.generate(
      2,
      (index) => Product(
        id: index,
        name: 'Chicken Burger Meal',
        description:
            'Delicious chicken burger with extra cheese and spicy sauce',
        price: '15.00',
        rating: '4.5',
        isFavorite: true,
        image: 'https://via.placeholder.com/150',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: RefreshIndicator(
        color: AppColors.primary,
        backgroundColor: AppColors.white,
        onRefresh: () async => context.read<FavCubit>().loadFavorites(),
        child: Scaffold(
          body: BlocListener<FavCubit, ToggleFavState>(
            listener: _listener,
            child: BlocBuilder<FavCubit, ToggleFavState>(
              builder: (context, state) {
                return switch (state) {
                  ToggleFavLoading() => Skeletonizer(
                      enabled: true,
                      child: FavListView(favorites: _getDummyProducts()),
                    ),
                  ToggleFavError() => FavErrorView(
                      message: state.message,
                      onRetry: () => context.read<FavCubit>().loadFavorites(),
                    ),
                  ToggleFavEmpty() => const FavEmptyView(),
                  ToggleFavSuccess() => FavListView(
                      favorites: state.favoriteProducts!,
                    ),
                  _ => const SizedBox.shrink(),
                };
              },
            ),
          ),
        ),
      ),
    );
  }

  void _listener(BuildContext context, ToggleFavState state) {
    if (state is ToggleFavError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
