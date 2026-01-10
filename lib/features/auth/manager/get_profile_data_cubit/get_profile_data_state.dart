part of 'get_profile_data_cubit.dart';

sealed class GetProfileDataState {}

final class GetProfileDataInitial extends GetProfileDataState {}

final class GetProfileDataLoading extends GetProfileDataState {}

final class GetProfileDataEmpty extends GetProfileDataState {
  final Widget? guest;
  GetProfileDataEmpty({this.guest});
}

final class GetProfileDataSuccess extends GetProfileDataState {
  final GetProfileDataModel profileData;
  GetProfileDataSuccess({required this.profileData});
}

final class GetProfileDataFailure extends GetProfileDataState {
  final String error;
  GetProfileDataFailure({required this.error});
}
