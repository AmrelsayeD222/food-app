import 'package:dartz/dartz.dart';
import 'package:foods_app/features/auth/data/model/get_profile_data_model.dart';
import 'package:foods_app/features/auth/data/model/post_profile_data_model.dart';

import '../../../../core/network/errors/failure.dart';
import '../model/login_model.dart';
import '../model/sign_up_model.dart';

abstract class Repo {
  Future<Either<Failure, LoginModel>> login(
      {required String email, required String password});

  Future<Either<Failure, SignUpModel>> signUp(
      {required String name, required String email, required String password});

  Future<Either<Failure, GetProfileDataModel>> getProfileData();
  Future<Either<Failure, PostProfileResponse>> postProfileData({
    String? name,
    String? imagePath,
  });
}
