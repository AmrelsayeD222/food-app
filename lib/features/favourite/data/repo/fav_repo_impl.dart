import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:foods_app/core/network/errors/failure.dart';
import 'package:foods_app/core/network/services/api_service.dart';
import 'package:foods_app/features/favourite/data/model/add_and_remove_fav_model.dart';
import 'package:foods_app/features/favourite/data/model/get_fav_model.dart';
import 'package:foods_app/features/favourite/data/repo/fav_repo.dart';

class FavRepoImpl implements FavRepo {
  final ApiServices apiServices;
  FavRepoImpl({required this.apiServices});

  @override
  Future<Either<Failure, GetFavoritesResponse>> getFav(
      {required String token}) async {
    try {
      final response = await apiServices.get(
        endPoint: 'favorites',
        token: token,
      );
      final getFavoritesResponse = GetFavoritesResponse.fromJson(response);
      return Right(getFavoritesResponse);
    } catch (e) {
      if (e is DioException) {
        return Left(
          ServerFailure.fromDioError(e),
        );
      } else {
        return Left(
          ServerFailure(e.toString()),
        );
      }
    }
  }

  @override
  Future<Either<Failure, AddAndRemoveFavResponse>> toggleFav(
      {required String token, required int productId}) async {
    try {
      final response = await apiServices.post(
        endPoint: 'favorites',
        token: token,
        data: {'product_id': productId},
      );
      final addAndRemoveFavResponse =
          AddAndRemoveFavResponse.fromJson(response);
      return Right(addAndRemoveFavResponse);
    } catch (e) {
      if (e is DioException) {
        return Left(
          ServerFailure.fromDioError(e),
        );
      } else {
        return Left(
          ServerFailure(e.toString()),
        );
      }
    }
  }
}
