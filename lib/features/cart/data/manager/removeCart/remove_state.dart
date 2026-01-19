part of 'remove_cubit.dart';

sealed class RemoveState extends Equatable {
  const RemoveState();

  @override
  List<Object?> get props => [];
}

final class RemoveInitial extends RemoveState {}

final class RemoveLoading extends RemoveState {
  final int itemId;
  const RemoveLoading({required this.itemId});

  @override
  List<Object?> get props => [itemId];
}

final class RemoveSuccess extends RemoveState {
  final RemoveItemResponseModel removeItemResponse;
  final int itemId;

  const RemoveSuccess({
    required this.removeItemResponse,
    required this.itemId,
  });

  @override
  List<Object?> get props => [removeItemResponse, itemId];
}

final class RemoveFailure extends RemoveState {
  final String errMessage;
  final int itemId;

  const RemoveFailure({
    required this.errMessage,
    required this.itemId,
  });

  @override
  List<Object?> get props => [errMessage, itemId];
}
