import 'package:bloc/bloc.dart';
import 'package:foods_app/features/home/data/model/home_product_model.dart';
import 'package:foods_app/features/home/data/repo/home_repo.dart';

part 'home_product_state.dart';

class HomeProductCubit extends Cubit<HomeProductState> {
  final HomeRepo homeRepo;

  HomeProductCubit(this.homeRepo) : super(HomeProductInitial());

  Future<void> fetchProduct({bool forceRefresh = false}) async {
    if (isClosed) return;

    if (!forceRefresh && state is HomeProductLoaded) return;

    emit(HomeProductLoading());

    final result = await homeRepo.fetchProduct();

    if (isClosed) return;

    result.fold(
      (failure) => emit(HomeProductError(failure.errMessage)),
      (data) => emit(HomeProductLoaded(data.data)),
    );
  }
}
