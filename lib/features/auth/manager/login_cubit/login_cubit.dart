import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:foods_app/core/di/service_locator.dart';
import 'package:foods_app/features/auth/manager/get_profile_data_cubit/get_profile_data_cubit.dart';
import 'package:foods_app/features/cart/data/manager/cartCubit/cart_cubit_cubit.dart';
import '../../data/repo/repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final Repo loginRepo;

  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  bool loginIsObscure = true;

  LoginCubit(this.loginRepo) : super(LoginInitial());

  Future<void> login() async {
    emit(LoginLoading());

    final result = await loginRepo.login(
      email: loginEmailController.text.trim(),
      password: loginPasswordController.text.trim(),
    );

    result.fold(
      (failure) => emit(LoginFailure(failure.errMessage)),
      (response) => emit(LoginSuccess(
        response,
      )),
    );
  }

  void validateAndLogin() {
    if (loginFormKey.currentState?.validate() ?? false) {
      login();
    }
  }

  void togglePasswordVisibility() {
    loginIsObscure = !loginIsObscure;
    emit(LoginPasswordVisibilityChanged());
  }

  void clearFields() {
    loginEmailController.clear();
    loginPasswordController.clear();
    loginIsObscure = true;
    loginFormKey.currentState?.reset();
    emit(LoginInitial());
  }

  void clearPreviousData() {
    try {
      getIt<CartCubitCubit>().clearCart();
      getIt<GetProfileDataCubit>().clearProfile();
    } catch (e) {
      debugPrint('Error clearing data on login: $e');
    }
  }

  void loginAsGuest() {
    try {
      getIt<CartCubitCubit>().clearCart();
      getIt<GetProfileDataCubit>().clearProfile();
      emit(GuestModeSuccess());
    } catch (e) {
      emit(LoginFailure('Failed to enter guest mode'));
    }
  }

  @override
  Future<void> close() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    return super.close();
  }
}
