part of 'post_profile_data_cubit.dart';

sealed class PostProfileDataState {}

final class PostProfileDataInitial extends PostProfileDataState {}

final class PostProfileDataLoading extends PostProfileDataState {}

final class PostProfileDataSuccess extends PostProfileDataState {
  final PostProfileResponse response;

  PostProfileDataSuccess({required this.response});
}

final class PostProfileDataFailure extends PostProfileDataState {
  final String errorMessage;

  PostProfileDataFailure({required this.errorMessage});
}
