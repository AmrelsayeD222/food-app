import 'package:bloc/bloc.dart';
import 'package:foods_app/features/favourite/data/manager/addAndRemoveFav/cubit/add_and_remove_state.dart';
import 'package:foods_app/features/favourite/data/repo/fav_repo.dart';

class AddAndRemoveFavCubit extends Cubit<AddAndRemoveFavState> {
  final FavRepo favRepo;

  AddAndRemoveFavCubit(this.favRepo) : super(AddAndRemoveInitial());

  Future<void> toggleFav({
    required String token,
    required int productId,
  }) async {
    emit(AddAndRemoveLoading(productId));

    final result = await favRepo.toggleFav(
      token: token,
      productId: productId,
    );

    result.fold(
      (failure) => emit(AddAndRemoveFailure(
        errorMessage: failure.errMessage,
        productId: productId,
      )),
      (success) => emit(AddAndRemoveSuccess(
        response: success,
        productId: productId,
      )),
    );
  }
}
