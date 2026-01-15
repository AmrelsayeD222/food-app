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
    return BlocBuilder<FavCubit, FavState>(
      buildWhen: (previous, current) {
        final prevIsFavorite = previous.isFavorite(productId);
        final currIsFavorite = current.isFavorite(productId);
        final prevIsLoading =
            (previous is AddLoading && previous.productId == productId) ||
                (previous is RemoveLoading && previous.productId == productId);
        final currIsLoading =
            (current is AddLoading && current.productId == productId) ||
                (current is RemoveLoading && current.productId == productId);

        return prevIsFavorite != currIsFavorite ||
            prevIsLoading != currIsLoading;
      },
      builder: (context, state) {
        final isFavorite = state.isFavorite(productId);
        final isAdding = state is AddLoading && state.productId == productId;
        final isRemoving =
            state is RemoveLoading && state.productId == productId;
        final isLoading = isAdding || isRemoving;

        return GestureDetector(
          onTap: isLoading
              ? null
              : () {
                  context.read<FavCubit>().toggleFav(
                        productId: productId,
                        isAdding: !isFavorite,
                      );
                },
          child: Align(
            alignment: Alignment.topRight,
            child: isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.red,
                    ),
                  )
                : Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                    size: 22,
                  ),
          ),
        );
      },
    );
  }
}
