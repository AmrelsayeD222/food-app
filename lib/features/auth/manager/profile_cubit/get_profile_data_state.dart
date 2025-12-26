part of 'get_profile_data_cubit.dart';

sealed class GetProfileDataState {}

final class GetProfileDataInitial extends GetProfileDataState {}

final class GetProfileDataLoading extends GetProfileDataState {}

final class GetProfileDataSuccess extends GetProfileDataState {
  final GetProfileDataModel data;
  GetProfileDataSuccess(this.data);
}

final class GetProfileDataFailure extends GetProfileDataState {
  final Failure failure;
  GetProfileDataFailure(this.failure);
}
