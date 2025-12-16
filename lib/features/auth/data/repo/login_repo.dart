import 'package:dartz/dartz.dart';

import '../../../../core/network/failure.dart';
import '../model/login_model.dart';

abstract class LoginRepo {
  Future<Either<Failure, LoginModel>> login(
      {required String email, required String password});
}
