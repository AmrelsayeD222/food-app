import 'package:bloc/bloc.dart';
import 'package:foods_app/features/favourite/data/model/get_fav_response.dart';
import 'package:foods_app/features/favourite/data/repo/fav_repo.dart';

part 'get_state.dart';

class GetFavCubit extends Cubit<GetFavState> {
  final FavRepo favRepo;
  GetFavCubit(this.favRepo) : super(GetFavInitial());

  Future<void> getFavorites({bool isLoading = true}) async {
    if (isLoading) emit(GetFavLoading());
    final result = await favRepo.getFavorites();
    result.fold(
      (failure) => emit(GetFavFailure(error: failure.errMessage)),
      (success) => success.data.isEmpty
          ? emit(GetFavEmpty(
              emptymessage: "No Favourites Found",
            ))
          : emit(
              GetFavSuccess(response: success),
            ),
    );
  }
}
