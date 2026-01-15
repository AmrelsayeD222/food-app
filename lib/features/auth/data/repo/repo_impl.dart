import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:foods_app/core/network/errors/failure.dart';
import 'package:foods_app/core/network/services/api_service.dart';
import 'package:foods_app/features/auth/data/model/get_profile_data_model.dart';

import 'package:foods_app/features/auth/data/model/login_model.dart';
import 'package:foods_app/features/auth/data/model/post_profile_data_model.dart';
import 'package:foods_app/features/auth/data/model/sign_up_model.dart';

import '../../../../core/helper/shared_pref_storage.dart';
import 'repo.dart';

class RepoImpl implements Repo {
  final ApiServices apiServices;
  final SharedPrefsService prefsService;
  RepoImpl(
    this.apiServices,
    this.prefsService,
  );
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
      final loginModel = LoginModel.fromJson(response);

      final token = loginModel.data?.token;
      if (token != null && token.isNotEmpty) {
        await prefsService.saveToken(token);
      }

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

  @override
  Future<Either<Failure, SignUpModel>> signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      var response = await apiServices.post(
        endPoint: 'register',
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );
      final signUpModel = SignUpModel.fromJson(response);

      final token = signUpModel.data?.token;
      if (token != null && token.isNotEmpty) {
        await prefsService.saveToken(token);
      }

      return Right(signUpModel);
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

  @override
  Future<Either<Failure, GetProfileDataModel>> getProfileData() async {
    try {
      var response = await apiServices.get(
        endPoint: 'profile',
      );
      final profileData = response['data'] ?? {};
      return Right(GetProfileDataModel.fromJson(profileData));
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

  @override
  Future<Either<Failure, PostProfileResponse>> postProfileData({
    String? name,
    String? imagePath,
  }) async {
    try {
      final formData = FormData.fromMap({
        if (name != null) 'name': name,
        if (imagePath != null)
          'image': await MultipartFile.fromFile(
            imagePath,
            filename: imagePath.split('/').last,
          ),
      });

      final response = await apiServices.postFormData(
        endPoint: 'update-profile',
        data: formData,
      );

      return Right(PostProfileResponse.fromJson(response));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }
}
