import 'package:bloc/bloc.dart';
import 'package:foods_app/features/favourite/data/model/getFav/get_fav_response.dart';
import 'package:foods_app/features/favourite/data/repo/fav_repo.dart';

part 'fav_state.dart';

class FavCubit extends Cubit<FavState> {
  final FavRepo favRepo;

  FavCubit(this.favRepo) : super(const FavInitial());

  Future<void> loadFavorites() async {
    final currentIds = state.favoriteIds;
    final currentProducts = state.favoriteProducts;
    emit(FavLoading(
      favoriteIds: currentIds,
      favoriteProducts: currentProducts,
    ));

    final result = await favRepo.getFavorites();
    result.fold(
      (failure) => emit(FavError(
        favoriteIds: currentIds,
        favoriteProducts: currentProducts,
        message: failure.errMessage,
      )),
      (success) {
        Set<int> favoriteIds = success.data.map((e) => e.id).toSet();
        if (success.data.isEmpty) {
          emit(FavEmpty(
            favoriteIds: favoriteIds,
            favoriteProducts: const [],
            message: "No Favourites Found",
          ));
        } else {
          emit(FavSuccess(
            favoriteIds: favoriteIds,
            favoriteProducts: success.data,
          ));
        }
      },
    );
  }

  Future<void> toggleFavorite(int productId) async {
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
      updatedProducts = previousProducts;
    }

    emit(FavSuccess(
      favoriteIds: previousIds,
      favoriteProducts: updatedProducts,
      togglingProductIds: {productId},
    ));

    final result = await favRepo.addFav(productId: productId);
    result.fold(
      (failure) => emit(FavError(
        favoriteIds: state.favoriteIds,
        favoriteProducts: state.favoriteProducts,
        message: failure.errMessage,
      )),
      (success) => emit(FavSuccess(
        favoriteIds: previousIds,
        favoriteProducts: updatedProducts,
        togglingProductIds: const {},
      )),
    );
  }

  bool isFavorite(int productId) {
    return state.favoriteIds.contains(productId);
  }
}
