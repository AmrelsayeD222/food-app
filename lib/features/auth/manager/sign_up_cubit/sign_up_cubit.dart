import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:foods_app/core/di/service_locator.dart';
import 'package:foods_app/features/auth/data/model/sign_up_model.dart';
import 'package:foods_app/features/auth/manager/get_profile_data_cubit/get_profile_data_cubit.dart';
import 'package:foods_app/features/cart/data/manager/getCartCubit/cart_cubit_cubit.dart';
import 'package:foods_app/features/favourite/data/manager/toggle/fav_cubit.dart';

import '../../data/repo/repo.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final Repo signUpRepo;
  final TextEditingController signUpEmailController = TextEditingController();
  final TextEditingController signUpPasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  bool signUpIsObscure = true;

  SignUpCubit(this.signUpRepo) : super(SignUpInitial());

  Future<void> signUp() async {
    emit(SignUpLoading());

    final result = await signUpRepo.signUp(
      email: signUpEmailController.text.trim(),
      password: signUpPasswordController.text.trim(),
      name: nameController.text.trim(),
      address: addressController.text.trim(),
    );

    result.fold(
      (failure) => emit(SignUpFailure(failure.errMessage)),
      (response) async {
        if (addressController.text.trim().isNotEmpty) {
          await signUpRepo.postProfileData(
            address: addressController.text.trim(),
          );
        }
        await clearPreviousData();
        emit(SignUpSuccess(response));
      },
    );
  }

  void validateAndSign() {
    if (signUpFormKey.currentState?.validate() ?? false) {
      signUp();
    }
  }

  void signUpTogglePasswordVisibility() {
    signUpIsObscure = !signUpIsObscure;
    emit(SignUpPasswordVisibilityChanged());
  }

  void signClearFields() {
    signUpEmailController.clear();
    signUpPasswordController.clear();
    nameController.clear();
    addressController.clear();
    signUpIsObscure = true;
    signUpFormKey.currentState?.reset();
    emit(SignUpInitial());
  }

  Future<void> clearPreviousData() async {
    try {
      await getIt<CartCubitCubit>().clearCart();
      getIt<GetProfileDataCubit>().clearProfile();
      await getIt<FavCubit>().clearFavorites();
    } catch (e) {
      debugPrint('Error clearing data on Sign Up: $e');
    }
  }

  Future<void> signUpAsGuest() async {
    try {
      await getIt<CartCubitCubit>().clearCart();
      getIt<GetProfileDataCubit>().clearProfile();
      await getIt<FavCubit>().clearFavorites();
      emit(SignUpGuestModeSuccess());
    } catch (e) {
      emit(SignUpFailure('Failed to enter guest mode'));
    }
  }

  @override
  Future<void> close() {
    signUpEmailController.dispose();
    signUpPasswordController.dispose();
    nameController.dispose();
    addressController.dispose();
    return super.close();
  }
}
