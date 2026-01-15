import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/features/favourite/data/model/addAndRemoveFav/add_and_remove.dart';
import 'package:foods_app/features/favourite/data/repo/fav_repo.dart';

part 'add_and_remove_state.dart';

class AddCubit extends Cubit<AddState> {
  final FavRepo favRepo;

  AddCubit(this.favRepo) : super(AddInitial());

  Future<void> addFav({required int productId}) async {
    emit(AddLoading());
    final result = await favRepo.toggleFav(productId: productId);
    result.fold(
      (failure) {
        emit(AddFailure(error: failure.errMessage));
      },
      (success) {
        emit(AddSuccess(response: success));
      },
    );
  }
}

class RemoveCubit extends Cubit<RemoveState> {
  final FavRepo favRepo;

  RemoveCubit(this.favRepo) : super(RemoveInitial());

  Future<void> removeFav({required int productId}) async {
    emit(RemoveLoading());
    final result = await favRepo.toggleFav(productId: productId);
    result.fold(
      (failure) {
        emit(RemoveFailure(error: failure.errMessage));
      },
      (success) {
        emit(RemoveSuccess(response: success));
      },
    );
  }
}
