import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foods_app/features/favourite/data/manager/toggle/fav_cubit.dart';
import 'package:foods_app/features/favourite/widgets/fav_item_card.dart';
import 'package:foods_app/features/home/data/model/home_product_model.dart';

class FavListView extends StatelessWidget {
  final List<Product> favorites;

  const FavListView({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => context.read<FavCubit>().loadFavorites(),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        itemCount: favorites.length,
        itemBuilder: (_, index) {
          return FavItemCard(product: favorites[index]);
        },
      ),
    );
  }
}
