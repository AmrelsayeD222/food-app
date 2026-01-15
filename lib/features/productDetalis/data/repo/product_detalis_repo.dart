import 'package:dartz/dartz.dart';
import 'package:foods_app/core/network/errors/failure.dart';
import 'package:foods_app/features/productDetalis/data/model/order_response.dart';
import 'package:foods_app/features/productDetalis/data/model/oreder_request_model.dart';

abstract class ProductDetalisRepo {
  Future<Either<Failure, OrderResponse>> createOrder({
    required OrderRequest orderRequest,
  });
}
