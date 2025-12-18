import 'package:dartz/dartz.dart';

import '../../../../core/network/errors/failure.dart';
import '../model/login_model.dart';

abstract class LoginRepo {
  Future<Either<Failure, LoginModel>> login(
      {required String email, required String password});
}
