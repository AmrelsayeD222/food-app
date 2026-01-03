import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../data/repo/repo.dart';
import 'loign_state.dart';

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
}
