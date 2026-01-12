part of 'get_fav_cubit.dart';

sealed class GetFavState {}

final class GetFavInitial extends GetFavState {}

final class GetFavLoading extends GetFavState {}

final class GetFavSuccess extends GetFavState {
  final GetFavoritesResponse response;

  GetFavSuccess(this.response);
}

final class GetFavFailure extends GetFavState {
  final String errorMessage;

  GetFavFailure(this.errorMessage);
}

final class GetFavEmpty extends GetFavState {}
