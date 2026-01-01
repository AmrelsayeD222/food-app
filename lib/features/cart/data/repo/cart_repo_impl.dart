import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:foods_app/core/network/errors/failure.dart';
import 'package:foods_app/core/network/services/api_service.dart';
import 'package:foods_app/features/cart/data/model/cart_response_model.dart';
import 'package:foods_app/features/cart/data/repo/cart_repo.dart';

class CartRepoImpl implements CartRepo {
  final ApiServices apiServices;
  CartRepoImpl({required this.apiServices});

  @override
  Future<Either<Failure, CartResponseModel>> getCart(
      {required String token}) async {
    try {
      final response = await apiServices.get(
        endPoint: 'cart',
        token: token,
      );
      final cartResponse = CartResponseModel.fromJson(response);
      return Right(cartResponse);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
