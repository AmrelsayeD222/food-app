import 'package:bloc/bloc.dart';
import 'package:foods_app/features/cart/data/model/cart_response_model.dart';
import 'package:foods_app/features/cart/data/repo/cart_repo.dart';

part 'cart_cubit_state.dart';

class CartCubitCubit extends Cubit<CartCubitState> {
  final CartRepo repo;

  CartCubitCubit(this.repo) : super(CartCubitInitial());

  Future<void> getCart({
    required String? token,
    bool forceRefresh = false,
  }) async {
    if (isClosed) return;

    if (token == null || token.isEmpty) {
      emit(CartCubitEmpty(message: "please login to continue shopping!"));
      return;
    }

    if (!forceRefresh && state is CartCubitSuccess) return;

    emit(CartCubitLoading());

    final result = await repo.getCart(token: token);

    if (isClosed) return;

    result.fold(
      (failure) {
        if (failure.errMessage.toLowerCase().contains('cart') ||
            failure.errMessage.toLowerCase().contains('empty') ||
            failure.errMessage.toLowerCase().contains('not found') ||
            failure.errMessage.toLowerCase().contains('null')) {
          emit(CartCubitEmpty(message: "Your cart is empty. Start shopping!"));
        } else {
          emit(CartCubitFailure(errMessage: failure.errMessage));
        }
      },
      (response) {
        if (response.items.isEmpty) {
          emit(CartCubitEmpty(message: "please login to continue shopping!"));
        } else {
          emit(CartCubitSuccess(cartResponse: response));
        }
      },
    );
  }
}
