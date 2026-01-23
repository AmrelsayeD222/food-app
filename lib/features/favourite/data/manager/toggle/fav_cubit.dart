import 'package:bloc/bloc.dart';
import 'package:foods_app/features/favourite/data/model/get_fav_response.dart';
import 'package:foods_app/features/favourite/data/repo/fav_repo.dart';
import 'package:foods_app/core/helper/shared_pref_storage.dart';
import 'package:foods_app/features/home/data/model/home_product_model.dart';

part 'fav_state.dart';

class FavCubit extends Cubit<ToggleFavState> {
  final FavRepo favRepo;
  final SharedPrefsService _sharedPrefsService;

  FavCubit(this.favRepo, this._sharedPrefsService)
      : super(const ToggleFavInitial());

  Future<void> loadFavorites({bool forceRefresh = false}) async {
    // 1. Try to load from cache first
    if (!forceRefresh) {
      final cachedFavs = await _sharedPrefsService.getFavorites();
      if (cachedFavs != null && cachedFavs.data.isNotEmpty) {
        Set<int> favoriteIds = cachedFavs.data.map((e) => e.id).toSet();
        emit(ToggleFavSuccess(
          favoriteIds: favoriteIds,
          favoriteProducts: cachedFavs.data,
        ));
      }
    }

    // Skip if already loading or already loaded and not forcing refresh
    if (state is ToggleFavLoading) return;
    if (!forceRefresh &&
        (state is ToggleFavSuccess || state is ToggleFavEmpty)) {
      return;
    }

    final currentIds = state.favoriteIds;
    final currentProducts = state.favoriteProducts;
    emit(ToggleFavLoading(
      favoriteIds: currentIds,
      favoriteProducts: currentProducts,
    ));

    final result = await favRepo.getFavorites();
    result.fold(
      (failure) {
        // Check if user is in guest mode (not authenticated)
        if (failure.errMessage.toLowerCase().contains('unauthenticated')) {
          // Show empty state for guest users instead of error
          emit(const ToggleFavEmpty(
            favoriteIds: {},
            favoriteProducts: [],
            message: "No Favourites Found",
          ));
        } else {
          // Show error for other failure types
          emit(ToggleFavError(
            favoriteIds: currentIds,
            favoriteProducts: currentProducts,
            message: failure.errMessage,
          ));
        }
      },
      (success) async {
        // 2. Save to cache
        await _sharedPrefsService.saveFavorites(success);

        Set<int> favoriteIds = success.data.map((e) => e.id).toSet();
        if (success.data.isEmpty) {
          emit(ToggleFavEmpty(
            favoriteIds: favoriteIds,
            favoriteProducts: const [],
            message: "No Favourites Found",
          ));
        } else {
          emit(ToggleFavSuccess(
            favoriteIds: favoriteIds,
            favoriteProducts: success.data,
          ));
        }
      },
    );
  }

  Future<void> toggleFavorite(
      {required int productId, Product? product}) async {
    final previousIds = Set<int>.from(state.favoriteIds);
    final previousProducts = state.favoriteProducts;
    final wasFavorite = previousIds.contains(productId);

    List<FavoriteProduct>? updatedProducts;
    if (wasFavorite) {
      previousIds.remove(productId);
      updatedProducts =
          previousProducts?.where((p) => p.id != productId).toList();
    } else {
      previousIds.add(productId);
      if (product != null) {
        // Create FavoriteProduct from Product
        final newFav = FavoriteProduct(
          id: product.id,
          name: product.name,
          image: product.image,
          price: product.price,
          description: product.description,
          isFavorite: true,
          rating: product.rating,
        );
        updatedProducts = List.from(previousProducts ?? [])..add(newFav);
      } else {
        updatedProducts = previousProducts;
      }
    }

    emit(ToggleFavSuccess(
      favoriteIds: previousIds,
      favoriteProducts: updatedProducts,
      togglingProductIds: {productId},
    ));

    final result = await favRepo.toggleFav(productId: productId);
    result.fold(
      (failure) => emit(ToggleFavError(
        favoriteIds: state.favoriteIds,
        favoriteProducts: state.favoriteProducts,
        message: failure.errMessage,
      )),
      (success) async {
        // Update cache
        if (updatedProducts != null) {
          await _sharedPrefsService.saveFavorites(GetFavResponseModel(
            code: 200,
            message: 'Success',
            data: updatedProducts,
          ));
        }

        // Check if favorites list is now empty
        if (updatedProducts == null || updatedProducts.isEmpty) {
          emit(const ToggleFavEmpty(
            favoriteIds: {},
            favoriteProducts: [],
            message: "No Favourites Found",
          ));
        } else {
          emit(ToggleFavSuccess(
            favoriteIds: previousIds,
            favoriteProducts: updatedProducts,
            togglingProductIds: const {},
          ));
        }
      },
    );
  }

  bool isFavorite(int productId) {
    return state.favoriteIds.contains(productId);
  }

  Future<void> clearFavorites() async {
    await _sharedPrefsService.saveFavorites(const GetFavResponseModel(
      code: 200,
      message: 'Success',
      data: [],
    ));
    emit(const ToggleFavInitial());
  }
}
