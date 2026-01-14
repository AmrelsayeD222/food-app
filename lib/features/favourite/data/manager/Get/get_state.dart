part of 'get_cubit.dart';

sealed class GetFavState {}

final class GetFavInitial extends GetFavState {}

final class GetFavLoading extends GetFavState {}

final class GetFavSuccess extends GetFavState {
  final GetFavResponseModel response;
  GetFavSuccess({required this.response});
}

final class GetFavFailure extends GetFavState {
  final String error;
  GetFavFailure({required this.error});
}

final class GetFavEmpty extends GetFavState {
  final String emptymessage;
  GetFavEmpty({required this.emptymessage});
}
