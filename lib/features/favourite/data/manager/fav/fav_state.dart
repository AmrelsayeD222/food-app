part of 'fav_cubit.dart';

sealed class FavState {
  bool isFavorite(int productId) {
    GetFavResponseModel? response;

    if (this is GetFavSuccess) {
      response = (this as GetFavSuccess).response;
    } else if (this is AddLoading) {
      response = (this as AddLoading).currentFavorites;
    } else if (this is RemoveLoading) {
      response = (this as RemoveLoading).currentFavorites;
    }

    if (response != null) {
      return response.data.any((e) => e.id == productId);
    }
    return false;
  }

  List<FavoriteProduct>? get favoriteProducts {
    GetFavResponseModel? response;

    if (this is GetFavSuccess) {
      response = (this as GetFavSuccess).response;
    } else if (this is AddLoading) {
      response = (this as AddLoading).currentFavorites;
    } else if (this is RemoveLoading) {
      response = (this as RemoveLoading).currentFavorites;
    }

    return response?.data;
  }
}

final class GetFavInitial extends FavState {}

final class GetFavLoading extends FavState {}

final class GetFavSuccess extends FavState {
  final GetFavResponseModel response;
  GetFavSuccess({required this.response});
}

final class GetFavFailure extends FavState {
  final String error;
  GetFavFailure({required this.error});
}

final class GetFavEmpty extends FavState {
  final String message;
  GetFavEmpty({required this.message});
}

final class AddInitial extends FavState {}

final class AddLoading extends FavState {
  final int? productId;
  final GetFavResponseModel? currentFavorites;
  AddLoading({this.productId, this.currentFavorites});
}

final class AddSuccess extends FavState {
  final AddAndRemoveModel response;
  AddSuccess({required this.response});
}

final class AddFailure extends FavState {
  final String error;
  AddFailure({required this.error});
}

// Remove States
final class RemoveInitial extends FavState {}

final class RemoveLoading extends FavState {
  final int? productId;
  final GetFavResponseModel? currentFavorites;
  RemoveLoading({this.productId, this.currentFavorites});
}

final class RemoveSuccess extends FavState {
  final AddAndRemoveModel response;
  RemoveSuccess({required this.response});
}

final class RemoveFailure extends FavState {
  final String error;
  RemoveFailure({required this.error});
}
