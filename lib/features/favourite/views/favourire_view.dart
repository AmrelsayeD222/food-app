import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/core/constants/app_colors.dart';
import 'package:foods_app/features/favourite/data/manager/toggle/fav_cubit.dart';
import 'package:foods_app/features/favourite/widgets/fav_empty_view.dart';
import 'package:foods_app/features/favourite/widgets/fav_error_view.dart';
import 'package:foods_app/features/favourite/widgets/fav_list_view.dart';
import 'package:foods_app/features/favourite/widgets/fav_loading.dart';

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
                  ToggleFavLoading() => const FavLoading(),
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
