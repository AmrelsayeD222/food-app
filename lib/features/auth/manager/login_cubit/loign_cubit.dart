import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../data/repo/login_repo.dart';
import 'loign_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo loginRepo;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginCubit(this.loginRepo) : super(LoginInitial());

  Future<void> login() async {
    emit(LoginLoading());

    final result = await loginRepo.login(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    result.fold(
      (failure) => emit(LoginFailure(failure.errMessage)),
      (_) => emit(LoginSuccess()),
    );
  }

  void validateAndLogin() {
    if (formKey.currentState?.validate() ?? false) {
      login();
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
