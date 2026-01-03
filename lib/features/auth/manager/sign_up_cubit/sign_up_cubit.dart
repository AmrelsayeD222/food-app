import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../data/repo/repo.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final Repo signUpRepo;
  final TextEditingController signUpEmailController = TextEditingController();
  final TextEditingController signUpPasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  bool signUpIsObscure = true;

  SignUpCubit(this.signUpRepo) : super(SignUpInitial());

  Future<void> signUp() async {
    emit(SignUpLoading());

    final result = await signUpRepo.signUp(
      email: signUpEmailController.text.trim(),
      password: signUpPasswordController.text.trim(),
      name: nameController.text.trim(),
    );

    result.fold(
      (failure) => emit(SignUpFailure(failure.errMessage)),
      (_) => emit(SignUpSuccess()),
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
    signUpIsObscure = true;
    signUpFormKey.currentState?.reset();
    emit(SignUpInitial());
  }
}
