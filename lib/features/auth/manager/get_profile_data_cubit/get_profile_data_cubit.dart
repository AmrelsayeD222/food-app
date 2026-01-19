import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:foods_app/core/di/service_locator.dart';
import 'package:foods_app/core/helper/shared_pref_storage.dart';
import 'package:foods_app/features/auth/data/model/get_profile_data_model.dart';
import 'package:foods_app/features/auth/data/repo/repo.dart';
import 'package:foods_app/features/cart/data/manager/cartCubit/cart_cubit_cubit.dart';

part 'get_profile_data_state.dart';

class GetProfileDataCubit extends Cubit<GetProfileDataState> {
  final Repo repo;
  final SharedPrefsService _sharedPrefsService;

  GetProfileDataCubit(this.repo, this._sharedPrefsService)
      : super(GetProfileDataInitial());

  /// 🔹 Fetch profile data safely
  Future<void> getProfileData({bool forceRefresh = false}) async {
    try {
      final token = await _sharedPrefsService.getToken();
      if (token == null || token.isEmpty) {
        if (!isClosed) {
          emit(GetProfileDataEmpty());
        }
        return;
      }

      // Skip if already loaded and not forcing refresh
      if (!forceRefresh && state is GetProfileDataSuccess) return;

      if (!isClosed) {
        emit(GetProfileDataLoading());
      }

      // Try to load from local storage first
      final cachedProfile = await _sharedPrefsService.getProfile();
      if (cachedProfile != null && !forceRefresh) {
        if (!isClosed) {
          emit(GetProfileDataSuccess(profileData: cachedProfile));
        }
      }

      final result = await repo.getProfileData();

      if (isClosed) return;

      result.fold(
        (failure) {
          final hasCachedData = state is GetProfileDataSuccess;

          if (!hasCachedData) {
            emit(GetProfileDataFailure(error: failure.errMessage));
          }
        },
        (profileData) async {
          await _sharedPrefsService.saveProfile(profileData);
          emit(GetProfileDataSuccess(profileData: profileData));
        },
      );
    } catch (e) {
      if (!isClosed) {
        emit(GetProfileDataFailure(error: 'Failed to load profile: $e'));
      }
      debugPrint('Error in getProfileData: $e');
    }
  }

  /// 🔹 Update profile from upload response (without API call)
  Future<void> updateProfileFromUpload(
      GetProfileDataModel updatedProfile) async {
    if (!isClosed) {
      // Save to local storage
      await _sharedPrefsService.saveProfile(updatedProfile);
      emit(GetProfileDataSuccess(profileData: updatedProfile));
    }
  }

  /// 🔹 Clear profile state and cart on logout
  Future<void> logout() async {
    try {
      // Clear cart data
      getIt<CartCubitCubit>().clearCart();

      // Clear token and profile
      await _sharedPrefsService.clearToken();

      if (!isClosed) {
        emit(GetProfileDataEmpty());
      }
    } catch (e) {
      debugPrint('Error during logout: $e');
      if (!isClosed) {
        emit(GetProfileDataFailure(error: 'Logout failed'));
      }
    }
  }

  /// 🔹 Clear profile state on new user sign in
  void clearProfile() {
    if (!isClosed) {
      emit(GetProfileDataInitial());
    }
  }
}
