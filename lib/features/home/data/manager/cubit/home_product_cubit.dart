import 'package:bloc/bloc.dart';
import 'package:foods_app/features/home/data/model/home_product_model.dart';
import 'package:foods_app/features/home/data/repo/home_repo.dart';

part 'home_product_state.dart';

class HomeProductCubit extends Cubit<HomeProductState> {
  HomeRepo homeRepo;
  HomeProductCubit(this.homeRepo) : super(HomeProductInitial());
  Future<void> fetchProduct() async {
    emit(HomeProductLoading());
    final result = await homeRepo.fetchProduct();
    result.fold(
      (failure) {
        emit(HomeProductError(failure.errMessage));
      },
      (data) {
        emit(HomeProductLoaded(data.data));
      },
    );
  }
}
