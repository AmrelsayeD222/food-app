import 'package:foods_app/features/favourite/data/model/addAndRemoveFav/add_and_remove_fav_model.dart';

sealed class AddAndRemoveFavState {}

final class AddAndRemoveInitial extends AddAndRemoveFavState {}

final class AddAndRemoveLoading extends AddAndRemoveFavState {
  final int productId;
  AddAndRemoveLoading(this.productId);
}

final class AddAndRemoveSuccess extends AddAndRemoveFavState {
  final AddAndRemoveFavResponse response;
  final int productId;

  AddAndRemoveSuccess({
    required this.response,
    required this.productId,
  });
}

final class AddAndRemoveFailure extends AddAndRemoveFavState {
  final String errorMessage;
  final int productId;

  AddAndRemoveFailure({
    required this.errorMessage,
    required this.productId,
  });
}
