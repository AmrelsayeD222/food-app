part of 'get_profile_data_cubit.dart';

abstract class GetProfileDataState {}

class GetProfileDataInitial extends GetProfileDataState {}

class GetProfileDataLoading extends GetProfileDataState {}

class GetProfileDataSuccess extends GetProfileDataState {
  final GetProfileDataModel profileData;

  GetProfileDataSuccess({required this.profileData});
}

class GetProfileDataFailure extends GetProfileDataState {
  final String error;

  GetProfileDataFailure({required this.error});
}

class GetProfileDataEmpty extends GetProfileDataState {}

class LogoutLoading extends GetProfileDataState {}

class LogoutSuccess extends GetProfileDataState {}
