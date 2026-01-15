import 'package:dartz/dartz.dart';
import 'package:foods_app/core/network/errors/failure.dart';
import 'package:foods_app/features/cart/data/model/cart_response_model.dart';

abstract class CartRepo {
  Future<Either<Failure, CartResponseModel>> getCart();
}
