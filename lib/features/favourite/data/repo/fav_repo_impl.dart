import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:foods_app/core/network/errors/failure.dart';
import 'package:foods_app/core/network/services/api_service.dart';
import 'package:foods_app/features/favourite/data/model/toggle_fav_model.dart';
import 'package:foods_app/features/favourite/data/model/get_fav_response.dart';
import 'package:foods_app/features/favourite/data/repo/fav_repo.dart';

class FavRepoImpl implements FavRepo {
  final ApiServices apiServices;
  FavRepoImpl({required this.apiServices});
  @override
  Future<Either<Failure, ToggleFavModel>> toggleFav({
    required int productId,
  }) async {
    try {
      final response = await apiServices.post(
        endPoint: 'toggle-favorite',
        data: {'product_id': productId},
      );
      return Right(ToggleFavModel.fromJson(response));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetFavResponseModel>> getFavorites() async {
    try {
      final response = await apiServices.get(
        endPoint: 'favorites',
      );
      return Right(GetFavResponseModel.fromJson(response));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }
}
