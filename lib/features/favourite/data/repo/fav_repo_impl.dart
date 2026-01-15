import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:foods_app/core/network/errors/failure.dart';
import 'package:foods_app/core/network/services/api_service.dart';
import 'package:foods_app/features/favourite/data/model/addAndRemoveFav/add_and_remove.dart';
import 'package:foods_app/features/favourite/data/model/getFav/get_fav_response.dart';
import 'package:foods_app/features/favourite/data/repo/fav_repo.dart';

class FavRepoImpl implements FavRepo {
  final ApiServices apiServices;
  FavRepoImpl({required this.apiServices});

  @override
  Future<Either<Failure, AddAndRemoveModel>> toggleFav({
    required int productId,
  }) async {
    try {
      final response = await apiServices.post(
        endPoint: 'toggle-favorite',
        data: {'product_id': productId},
      );
      return Right(AddAndRemoveModel.fromJson(response));
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
