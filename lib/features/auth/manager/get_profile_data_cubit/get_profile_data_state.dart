part of 'get_profile_data_cubit.dart';

sealed class GetProfileDataState {}

final class GetProfileDataInitial extends GetProfileDataState {}

final class GetProfileDataLoading extends GetProfileDataState {}

final class GetProfileDataEmpty extends GetProfileDataState {
  final String noTokenMessage;
  GetProfileDataEmpty({required this.noTokenMessage});
}

final class GetProfileDataSuccess extends GetProfileDataState {
  final GetProfileDataModel profileData;
  GetProfileDataSuccess({required this.profileData});
}

final class GetProfileDataFailure extends GetProfileDataState {
  final String error;
  GetProfileDataFailure({required this.error});
}
