import 'package:bloc/bloc.dart';
import 'package:foods_app/features/cart/data/model/cart_response_model.dart';
import 'package:foods_app/features/cart/data/repo/cart_repo.dart';

part 'cart_cubit_state.dart';

class CartCubitCubit extends Cubit<CartCubitState> {
  final CartRepo repo;

  CartCubitCubit(this.repo) : super(CartCubitInitial());
  Future<void> getCart({required String token}) async {
    if (isClosed) return;
    emit(CartCubitLoading());
    final result = await repo.getCart(token: token);
    if (isClosed) return;

    result.fold(
      (failure) => emit(CartCubitFailure(
        errMessage: failure.errMessage,
      )),
      (response) => emit(CartCubitSuccess(
        cartResponse: response,
      )),
    );
  }
}
