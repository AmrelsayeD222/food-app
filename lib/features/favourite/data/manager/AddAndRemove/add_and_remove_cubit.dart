import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/features/favourite/data/model/addAndRemoveFav/add_and_remove.dart';
import 'package:foods_app/features/favourite/data/repo/fav_repo.dart';

part 'add_and_remove_state.dart';

class AddCubit extends Cubit<AddState> {
  final FavRepo favRepo;

  AddCubit(this.favRepo) : super(AddInitial());

  Future<void> addFav({required String token, required int productId}) async {
    print('🔄 LOG: AddCubit.addFav called for $productId');
    emit(AddLoading());
    final result = await favRepo.addFav(token: token, productId: productId);
    result.fold(
      (failure) {
        print('❌ LOG: AddCubit Failed: ${failure.errMessage}');
        emit(AddFailure(error: failure.errMessage));
      },
      (success) {
        print('✅ LOG: AddCubit Success');
        emit(AddSuccess(response: success));
      },
    );
  }
}

class RemoveCubit extends Cubit<RemoveState> {
  final FavRepo favRepo;

  RemoveCubit(this.favRepo) : super(RemoveInitial());

  Future<void> removeFav(
      {required String token, required int productId}) async {
    print('🔄 LOG: RemoveCubit.removeFav called for $productId');
    emit(RemoveLoading());
    final result = await favRepo.removeFav(token: token, productId: productId);
    result.fold(
      (failure) {
        print('❌ LOG: RemoveCubit Failed: ${failure.errMessage}');
        emit(RemoveFailure(error: failure.errMessage));
      },
      (success) {
        print('✅ LOG: RemoveCubit Success');
        emit(RemoveSuccess(response: success));
      },
    );
  }
}
