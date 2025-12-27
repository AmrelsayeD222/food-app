import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:foods_app/core/network/errors/failure.dart';
import 'package:foods_app/features/auth/data/model/update_profile_model.dart';
import 'package:foods_app/features/auth/data/repo/repo.dart';

part 'update_profile_data_state.dart';

class UpdateProfileDataCubit extends Cubit<UpdateProfileDataState> {
  Repo getProfileDataRepo;
  final TextEditingController profileNameController = TextEditingController();
  final TextEditingController profileEmailController = TextEditingController();
  final TextEditingController profileAddressController =
      TextEditingController();
  UpdateProfileDataCubit(this.getProfileDataRepo)
      : super(UpdateProfileDataInitial());

  Future<void> updateProfile({
    required String token,
  }) async {
    emit(UpdateProfileDataLoading());

    final result = await getProfileDataRepo.updateProfile(
      token: token,
      name: profileNameController.text.trim(),
      email: profileEmailController.text.trim(),
      address: profileAddressController.text.trim(),
    );
    result.fold(
      (failure) {
        emit(UpdateProfileDataFailure(failure));
      },
      (data) {
        emit(UpdateProfileDataSuccess(data));
      },
    );
  }
}
