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
  Future<Either<Failure, AddAndRemoveModel>> addFav({
    required String token,
    required int productId,
  }) async {
    try {
      final response = await apiServices.post(
        endPoint: 'toggle-favorite',
        data: {'product_id': productId},
        token: token,
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
  Future<Either<Failure, GetFavResponseModel>> getFavorites(
      {required String token}) async {
    try {
      final response = await apiServices.get(
        endPoint: 'favorites',
        token: token,
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

  @override
  Future<Either<Failure, AddAndRemoveModel>> removeFav(
      {required String token, required int productId}) async {
    try {
      final response = await apiServices.post(
        endPoint: 'toggle-favorite',
        data: {'product_id': productId},
        token: token,
      );
      return Right(AddAndRemoveModel.fromJson(response));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
