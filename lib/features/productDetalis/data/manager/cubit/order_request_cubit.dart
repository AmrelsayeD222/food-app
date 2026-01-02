import 'package:bloc/bloc.dart';
import 'package:foods_app/features/productDetalis/data/model/oreder_request_model.dart';
import 'package:foods_app/features/productDetalis/data/repo/product_detalis_repo.dart';

part 'order_request_state.dart';

class OrderRequestCubit extends Cubit<OrderRequestState> {
  final ProductDetalisRepo repo;

  OrderRequestCubit(this.repo) : super(OrderRequestInitial());

  /// ينشئ أمر جديد
  /// [forceRefreshCart] هنا غير موجود، لأنه مسؤولية CartCubit تحديث نفسه بعد Success
  Future<void> createOrder({
    required String token,
    required OrderRequest request,
  }) async {
    if (isClosed) return;

    emit(OrderRequestLoading());

    final result = await repo.createOrder(token: token, orderRequest: request);

    if (isClosed) return;

    result.fold(
      (failure) => emit(OrderRequestFailure(
        errMessage: failure.errMessage,
      )),
      (response) => emit(OrderRequestSuccess(
        successMessage: response.message,
      )),
    );
  }
}
