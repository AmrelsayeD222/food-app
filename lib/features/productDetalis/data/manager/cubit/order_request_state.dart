part of 'order_request_cubit.dart';

sealed class OrderRequestState {}

final class OrderRequestInitial extends OrderRequestState {}

final class OrderRequestLoading extends OrderRequestState {}

final class OrderRequestSuccess extends OrderRequestState {
  final String successMessage;

  OrderRequestSuccess({required this.successMessage});
}

final class OrderRequestFailure extends OrderRequestState {
  final String errMessage;

  OrderRequestFailure({required this.errMessage});
}
