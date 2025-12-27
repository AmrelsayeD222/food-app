part of 'update_profile_data_cubit.dart';

sealed class UpdateProfileDataState {}

final class UpdateProfileDataInitial extends UpdateProfileDataState {}

final class UpdateProfileDataLoading extends UpdateProfileDataState {}

final class UpdateProfileDataSuccess extends UpdateProfileDataState {
  final UpdateProfileData data;
  UpdateProfileDataSuccess(this.data);
}

final class UpdateProfileDataFailure extends UpdateProfileDataState {
  final Failure failure;
  UpdateProfileDataFailure(this.failure);
}
