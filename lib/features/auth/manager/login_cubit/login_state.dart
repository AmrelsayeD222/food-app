import 'package:flutter/material.dart';
import 'package:foods_app/features/auth/data/model/login_model.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginModel loginModel;
  LoginSuccess(this.loginModel);
}

class LoginFailure extends LoginState {
  final String message;
  LoginFailure(this.message);
}

class LoginPasswordVisibilityChanged extends LoginState {}

class GuestModeSuccess extends LoginState {}
