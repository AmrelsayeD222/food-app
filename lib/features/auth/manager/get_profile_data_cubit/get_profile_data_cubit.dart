import 'package:bloc/bloc.dart';
import 'package:foods_app/features/auth/data/model/get_profile_data_model.dart';
import 'package:foods_app/features/auth/data/repo/repo.dart';

part 'get_profile_data_state.dart';

class GetProfileDataCubit extends Cubit<GetProfileDataState> {
  final Repo repo;
  GetProfileDataCubit(this.repo) : super(GetProfileDataInitial());

  /// 🔹 Fetch profile data safely
  Future<void> getProfileData(
      {required String token, bool forceRefresh = false}) async {
    if (token.isEmpty) {
      emit(GetProfileDataEmpty(noTokenMessage: "You are not logged in!"));
      return;
    }

    // Skip if already loaded and not forcing refresh
    if (!forceRefresh && state is GetProfileDataSuccess) return;

    if (!isClosed) {
      emit(GetProfileDataLoading());
    }
    final result = await repo.getProfileData(token: token);
    if (isClosed) return;
    result.fold(
      (failure) => emit(GetProfileDataFailure(error: failure.errMessage)),
      (profileData) => emit(GetProfileDataSuccess(profileData: profileData)),
    );
  }

  /// 🔹 Update profile from upload response (without API call)
  void updateProfileFromUpload({
    required String name,
    required String email,
    required String address,
    required String image,
    String? visa,
  }) {
    if (!isClosed) {
      final updatedProfile = GetProfileDataModel(
        name: name,
        email: email,
        address: address,
        image: image,
        visa: visa,
      );
      emit(GetProfileDataSuccess(profileData: updatedProfile));
    }
  }

  /// 🔹 Clear profile state on logout
  void logout() {
    if (!isClosed) {
      emit(GetProfileDataEmpty(noTokenMessage: "You are not logged in!"));
    }
  }

  /// 🔹 Clear profile state on new user sign in
  void clearProfile() {
    if (!isClosed) {
      emit(GetProfileDataInitial());
    }
  }
}
