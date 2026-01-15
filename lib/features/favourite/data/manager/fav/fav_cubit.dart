import 'package:bloc/bloc.dart';
import 'package:foods_app/features/favourite/data/model/addAndRemoveFav/add_and_remove.dart';
import 'package:foods_app/features/favourite/data/model/getFav/get_fav_response.dart';
import 'package:foods_app/features/favourite/data/repo/fav_repo.dart';

part 'fav_state.dart';

class FavCubit extends Cubit<FavState> {
  final FavRepo favRepo;

  FavCubit(this.favRepo) : super(GetFavInitial());

  Future<void> getFavorites({bool isLoading = true}) async {
    if (isLoading) emit(GetFavLoading());
    final result = await favRepo.getFavorites();
    result.fold(
      (failure) => emit(GetFavFailure(error: failure.errMessage)),
      (success) => success.data.isEmpty
          ? emit(GetFavEmpty(message: "No Favourites Found"))
          : emit(GetFavSuccess(response: success)),
    );
  }

  Future<void> toggleFav(
      {required int productId, required bool isAdding}) async {
    GetFavResponseModel? currentFavorites;
    if (state is GetFavSuccess) {
      currentFavorites = (state as GetFavSuccess).response;
    }

    if (isAdding) {
      emit(
          AddLoading(productId: productId, currentFavorites: currentFavorites));
    } else {
      emit(RemoveLoading(
          productId: productId, currentFavorites: currentFavorites));
    }

    final result = await favRepo.toggleFav(productId: productId);
    result.fold(
      (failure) {
        if (currentFavorites != null) {
          emit(GetFavSuccess(response: currentFavorites));
        }
        if (isAdding) {
          emit(AddFailure(error: failure.errMessage));
        } else {
          emit(RemoveFailure(error: failure.errMessage));
        }
      },
      (success) {
        if (isAdding) {
          emit(AddSuccess(response: success));
          if (currentFavorites != null) {
            emit(GetFavSuccess(response: currentFavorites));
          }
        } else {
          emit(RemoveSuccess(response: success));
          if (currentFavorites != null) {
            final updatedProducts =
                currentFavorites.data.where((p) => p.id != productId).toList();
            if (updatedProducts.isEmpty) {
              emit(GetFavEmpty(message: "No Favourites Found"));
            } else {
              emit(GetFavSuccess(
                response: currentFavorites.copyWith(data: updatedProducts),
              ));
            }
          }
        }
      },
    );
  }

  bool isFavorite(int productId) {
    return state.isFavorite(productId);
  }
}
