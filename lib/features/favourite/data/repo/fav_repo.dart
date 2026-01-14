import 'package:dartz/dartz.dart';
import 'package:foods_app/core/network/errors/failure.dart';
import 'package:foods_app/features/favourite/data/model/addAndRemoveFav/add_and_remove.dart';
import 'package:foods_app/features/favourite/data/model/getFav/get_fav_response.dart';

abstract class FavRepo {
  Future<Either<Failure, AddAndRemoveModel>> addFav({
    required String token,
    required int productId,
  });
  Future<Either<Failure, AddAndRemoveModel>> removeFav({
    required String token,
    required int productId,
  });

  Future<Either<Failure, GetFavResponseModel>> getFavorites({
    required String token,
  });
}
