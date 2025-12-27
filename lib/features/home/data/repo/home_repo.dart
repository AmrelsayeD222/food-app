import 'package:dartz/dartz.dart';
import 'package:foods_app/core/network/errors/failure.dart';
import 'package:foods_app/features/home/data/model/home_product_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, ProductResponse>> fetchProduct();
}
