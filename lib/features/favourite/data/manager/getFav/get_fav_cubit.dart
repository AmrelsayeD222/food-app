import 'package:bloc/bloc.dart';
import 'package:foods_app/features/favourite/data/model/get_fav_model.dart';
import 'package:foods_app/features/favourite/data/repo/fav_repo.dart';

part 'get_fav_state.dart';

class GetFavCubit extends Cubit<GetFavState> {
  final FavRepo favRepo;

  GetFavCubit(this.favRepo) : super(GetFavInitial());

  Future<void> getFav({required String token}) async {
    emit(GetFavLoading());

    final result = await favRepo.getFav(token: token);

    result.fold(
      (failure) => emit(GetFavFailure(failure.errMessage)),
      (success) {
        if (success.data.isEmpty) {
          emit(GetFavEmpty());
        } else {
          emit(GetFavSuccess(success));
        }
      },
    );
  }
}
