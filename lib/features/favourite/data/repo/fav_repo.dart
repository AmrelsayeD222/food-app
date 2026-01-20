import 'package:dartz/dartz.dart';
import 'package:foods_app/core/network/errors/failure.dart';
import 'package:foods_app/features/favourite/data/model/toggle_fav_model.dart';
import 'package:foods_app/features/favourite/data/model/get_fav_response.dart';

abstract class FavRepo {
  Future<Either<Failure, ToggleFavModel>> toggleFav({
    required int productId,
  });

  Future<Either<Failure, GetFavResponseModel>> getFavorites();
}
