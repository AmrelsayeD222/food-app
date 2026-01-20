part of 'fav_cubit.dart';

sealed class ToggleFavState {
  final Set<int> favoriteIds;
  final Set<int> togglingProductIds;
  final List<FavoriteProduct>? favoriteProducts;

  const ToggleFavState({
    required this.favoriteIds,
    this.togglingProductIds = const {},
    this.favoriteProducts,
  });
}

final class ToggleFavInitial extends ToggleFavState {
  const ToggleFavInitial()
      : super(
          favoriteIds: const {},
          togglingProductIds: const {},
          favoriteProducts: null,
        );
}

final class ToggleFavLoading extends ToggleFavState {
  const ToggleFavLoading({
    required super.favoriteIds,
    super.togglingProductIds = const {},
    super.favoriteProducts,
  });
}

final class ToggleFavSuccess extends ToggleFavState {
  const ToggleFavSuccess({
    required super.favoriteIds,
    super.togglingProductIds = const {},
    super.favoriteProducts,
  });
}

final class ToggleFavError extends ToggleFavState {
  final String message;
  const ToggleFavError({
    required super.favoriteIds,
    super.togglingProductIds = const {},
    super.favoriteProducts,
    required this.message,
  });
}

final class ToggleFavEmpty extends ToggleFavState {
  final String message;
  const ToggleFavEmpty({
    required super.favoriteIds,
    super.togglingProductIds = const {},
    super.favoriteProducts,
    required this.message,
  });
}
