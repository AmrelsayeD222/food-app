import 'package:dartz/dartz.dart';
import 'package:foods_app/core/network/errors/failure.dart';
import 'package:foods_app/features/favourite/data/model/add_and_remove_fav_model.dart';
import 'package:foods_app/features/favourite/data/model/get_fav_model.dart';

abstract class FavRepo {
  Future<Either<Failure, AddAndRemoveFavResponse>> toggleFav({
    required String token,
    required int productId,
  });

  Future<Either<Failure, GetFavoritesResponse>> getFav({required String token});
}
