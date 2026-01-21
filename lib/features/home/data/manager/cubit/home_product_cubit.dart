import 'package:bloc/bloc.dart';
import 'package:foods_app/features/home/data/model/home_product_model.dart';
import 'package:foods_app/features/home/data/repo/home_repo.dart';

part 'home_product_state.dart';

class HomeProductCubit extends Cubit<HomeProductState> {
  final HomeRepo homeRepo;
  List<Product> _allProducts = [];

  HomeProductCubit(this.homeRepo) : super(HomeProductInitial());

  Future<void> fetchProduct({bool forceRefresh = false}) async {
    if (isClosed) return;

    if (!forceRefresh && state is HomeProductLoaded) return;

    emit(HomeProductLoading());

    final result = await homeRepo.fetchProduct();

    if (isClosed) return;

    result.fold(
      (failure) => emit(HomeProductError(failure.errMessage)),
      (data) {
        _allProducts = data.data;
        emit(HomeProductLoaded(_allProducts));
      },
    );
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      emit(HomeProductLoaded(_allProducts));
    } else {
      final filteredProducts = _allProducts
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(HomeProductLoaded(filteredProducts));
    }
  }
}
