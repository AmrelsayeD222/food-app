import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:foods_app/core/network/errors/failure.dart';
import 'package:foods_app/core/network/services/api_service.dart';
import 'package:foods_app/features/productDetalis/data/model/order_response.dart';
import 'package:foods_app/features/productDetalis/data/model/oreder_request_model.dart';
import 'package:foods_app/features/productDetalis/data/repo/product_detalis_repo.dart';

class ProductDetalisRepoimpl implements ProductDetalisRepo {
  final ApiServices apiServices;

  ProductDetalisRepoimpl(this.apiServices);

  @override
  Future<Either<Failure, OrderResponse>> createOrder({
    required OrderRequest orderRequest,
  }) async {
    try {
      final response = await apiServices.post(
        endPoint: 'cart/add',
        data: orderRequest.toJson(),
      );

      final orderResponse = OrderResponse.fromJson(response, null);

      return Right(orderResponse);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
