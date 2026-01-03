import 'package:bloc/bloc.dart';
import 'package:foods_app/features/auth/data/model/get_profile_data_model.dart';
import 'package:foods_app/features/auth/data/repo/repo.dart';

part 'get_profile_data_state.dart';

class GetProfileDataCubit extends Cubit<GetProfileDataState> {
  final Repo repo;
  GetProfileDataCubit(this.repo) : super(GetProfileDataInitial());

  /// 🔹 Fetch profile data safely
  Future<void> getProfileData({required String token}) async {
    if (token.isEmpty) {
      emit(GetProfileDataEmpty(noTokenMessage: "You are not logged in!"));
      return;
    }
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

  /// 🔹 Clear profile state on logout
  void logout() {
    if (!isClosed) {
      emit(GetProfileDataEmpty(noTokenMessage: "You are not logged in!"));
    }
  }
}
