import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:foods_app/core/network/errors/failure.dart';
import 'package:foods_app/core/network/services/api_service.dart';
import 'package:foods_app/features/home/data/model/home_product_model.dart';
import 'package:foods_app/features/home/data/repo/home_repo.dart';

import 'package:foods_app/core/helper/shared_pref_storage.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiServices apiServices;
  final SharedPrefsService sharedPrefsService;

  HomeRepoImpl(this.apiServices, this.sharedPrefsService);

  @override
  Future<Either<Failure, ProductResponse>> fetchProduct() async {
    try {
      final response = await apiServices.get(endPoint: 'products');
      final productResponse = ProductResponse.fromJson(response);

      // Save to cache on success
      await sharedPrefsService.saveProducts(productResponse);

      return Right(productResponse);
    } catch (e) {
      // Try to load from cache on failure
      final cachedProducts = await sharedPrefsService.getProducts();
      if (cachedProducts != null) {
        return Right(cachedProducts);
      }

      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }
}
