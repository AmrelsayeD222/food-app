import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:foods_app/core/network/errors/failure.dart';
import 'package:foods_app/core/network/services/api_service.dart';

import 'package:foods_app/features/auth/data/model/login_model.dart';

import 'login_repo.dart';

class LoginRepoImpl implements LoginRepo {
  final ApiServices apiServices;
  LoginRepoImpl(this.apiServices);
  @override
  Future<Either<Failure, LoginModel>> login(
      {required String email, required String password}) async {
    try {
      var response = await apiServices.post(
        endPoint: 'login',
        data: {
          'email': email,
          'password': password,
        },
      );
      return Right(LoginModel.fromJson(response));
    } catch (e) {
      if (e is DioException) {
        return Left(
          ServerFailure.fromDioError(e),
        );
      } else {
        return Left(
          ServerFailure(e.toString()),
        );
      }
    }
  }
}
