import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/features/favourite/data/manager/fav/fav_cubit.dart';

class FavIcon extends StatelessWidget {
  final int productId;

  const FavIcon({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FavCubit, FavState,
        ({bool isFavorite, bool isToggling})>(
      selector: (state) => (
        isFavorite: state.favoriteIds.contains(productId),
        isToggling: state.togglingProductIds.contains(productId),
      ),
      builder: (context, data) {
        return GestureDetector(
          onTap: data.isToggling
              ? null
              : () {
                  context.read<FavCubit>().toggleFavorite(productId);
                },
          child: Align(
            alignment: Alignment.topRight,
            child: data.isToggling
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.red,
                    ),
                  )
                : Icon(
                    data.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: data.isFavorite ? Colors.red : Colors.grey,
                    size: 22,
                  ),
          ),
        );
      },
    );
  }
}
