import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:foods_app/core/network/errors/failure.dart';
import 'package:foods_app/features/auth/data/model/get_profile_model.dart';
import 'package:foods_app/features/auth/data/repo/repo.dart';

part 'get_profile_data_state.dart';

class GetProfileDataCubit extends Cubit<GetProfileDataState> {
  final Repo getProfileDataRepo;
  final TextEditingController profileNameController = TextEditingController();
  final TextEditingController profileEmailController = TextEditingController();
  final TextEditingController profileAddressController =
      TextEditingController();

  GetProfileDataCubit(this.getProfileDataRepo) : super(GetProfileDataInitial());
  Future<void> getProfileData({required String token}) async {
    emit(GetProfileDataLoading());

    final result = await getProfileDataRepo.getProfileData(token: token);

    result.fold(
      (failure) {
        log('PROFILE ERROR => ${failure.errMessage}');
        emit(GetProfileDataFailure(failure));
      },
      (data) {
        log('PROFILE SUCCESS => ${data.data?.name}');
        emit(GetProfileDataSuccess(data));
      },
    );
  }

  @override
  Future<void> close() {
    profileNameController.dispose();
    profileEmailController.dispose();
    profileAddressController.dispose();
    return super.close();
  }
}
