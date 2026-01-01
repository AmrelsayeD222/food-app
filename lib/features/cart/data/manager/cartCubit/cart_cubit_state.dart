part of 'cart_cubit_cubit.dart';

sealed class CartCubitState {}

final class CartCubitInitial extends CartCubitState {}

final class CartCubitLoading extends CartCubitState {}

final class CartCubitSuccess extends CartCubitState {
  final CartResponseModel cartResponse;

  CartCubitSuccess({required this.cartResponse});
}

final class CartCubitFailure extends CartCubitState {
  final String errMessage;

  CartCubitFailure({required this.errMessage});
}
