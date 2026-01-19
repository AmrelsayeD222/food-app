import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foods_app/features/cart/data/model/remove_item_response_model.dart';
import 'package:foods_app/features/cart/data/repo/cart_repo.dart';

part 'remove_state.dart';

class RemoveCubit extends Cubit<RemoveState> {
  final CartRepo repo;

  RemoveCubit(this.repo) : super(RemoveInitial());

  Future<void> removeItem({required int itemId}) async {
    emit(RemoveLoading(itemId: itemId));

    final result = await repo.removeItem(itemId: itemId);

    result.fold(
      (failure) {
        emit(
          RemoveFailure(
            errMessage: failure.errMessage,
            itemId: itemId,
          ),
        );
      },
      (response) {
        emit(
          RemoveSuccess(
            removeItemResponse: response,
            itemId: itemId,
          ),
        );
      },
    );
  }
}
