import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:foods_app/core/network/errors/failure.dart';
import 'package:foods_app/core/network/services/api_service.dart';
import 'package:foods_app/features/cart/data/model/cart_response_model.dart';
import 'package:foods_app/features/cart/data/model/remove_item_response_model.dart';
import 'package:foods_app/features/cart/data/repo/cart_repo.dart';

import 'package:foods_app/core/helper/shared_pref_storage.dart';

class CartRepoImpl implements CartRepo {
  final ApiServices apiServices;
  final SharedPrefsService sharedPrefsService;

  CartRepoImpl({required this.apiServices, required this.sharedPrefsService});

  @override
  Future<Either<Failure, CartResponseModel>> getCart() async {
    try {
      final response = await apiServices.get(
        endPoint: 'cart',
      );
      if (response['data'] == null) {
        // Try to load from cache if server says empty but maybe error?
        // Actually if server response is valid but null data, it usually means empty cart.
        // But let's stick to standard behavior: if network success, trust valid response.
        return Left(ServerFailure('Cart is empty or not created yet'));
      }
      final cartResponse = CartResponseModel.fromJson(response);

      // Save to cache
      await sharedPrefsService.saveCart(cartResponse);

      return Right(cartResponse);
    } on DioException catch (e) {
      // Try to load from cache
      final cachedCart = await sharedPrefsService.getCart();
      if (cachedCart != null) {
        return Right(cachedCart);
      }

      if (e.response?.statusCode == 500) {
        final errorMsg = e.response?.data?['message'] ?? '';
        if (errorMsg.contains('property') || errorMsg.contains('null')) {
          return Left(ServerFailure('Cart not found. Please add items first.'));
        }
      }
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      // Try to load from cache
      final cachedCart = await sharedPrefsService.getCart();
      if (cachedCart != null) {
        return Right(cachedCart);
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RemoveItemResponseModel>> removeItem({
    required int itemId,
  }) async {
    try {
      final response = await apiServices.delete(
        endPoint: 'cart/remove/$itemId',
      );

      // ✅ Handle 204 / empty response safely
      if (response.isEmpty) {
        return Right(
          RemoveItemResponseModel(
            code: 200,
            message: 'Item removed successfully',
            data: null,
          ),
        );
      }

      final removeItemResponse = RemoveItemResponseModel.fromJson(response);

      return Right(removeItemResponse);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
