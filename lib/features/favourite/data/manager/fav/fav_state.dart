part of 'fav_cubit.dart';

sealed class FavState {
  final Set<int> favoriteIds;
  final Set<int> togglingProductIds;
  final List<FavoriteProduct>? favoriteProducts;

  const FavState({
    required this.favoriteIds,
    this.togglingProductIds = const {},
    this.favoriteProducts,
  });
}

final class FavInitial extends FavState {
  const FavInitial()
      : super(
          favoriteIds: const {},
          togglingProductIds: const {},
          favoriteProducts: null,
        );
}

final class FavLoading extends FavState {
  const FavLoading({
    required super.favoriteIds,
    super.togglingProductIds = const {},
    super.favoriteProducts,
  });
}

final class FavSuccess extends FavState {
  const FavSuccess({
    required super.favoriteIds,
    super.togglingProductIds = const {},
    super.favoriteProducts,
  });
}

final class FavError extends FavState {
  final String message;
  const FavError({
    required super.favoriteIds,
    super.togglingProductIds = const {},
    super.favoriteProducts,
    required this.message,
  });
}

final class FavEmpty extends FavState {
  final String message;
  const FavEmpty({
    required super.favoriteIds,
    super.togglingProductIds = const {},
    super.favoriteProducts,
    required this.message,
  });
}
