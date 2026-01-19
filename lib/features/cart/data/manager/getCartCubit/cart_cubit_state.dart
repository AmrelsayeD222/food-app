part of 'cart_cubit_cubit.dart';

abstract class CartCubitState {}

class CartCubitInitial extends CartCubitState {}

class CartCubitLoading extends CartCubitState {}

class CartCubitFailure extends CartCubitState {
  final String errMessage;
  CartCubitFailure({required this.errMessage});
}

class CartCubitSuccess extends CartCubitState {
  final CartResponseModel cartResponse;
  CartCubitSuccess({required this.cartResponse});
}

class CartCubitEmpty extends CartCubitState {
  final String message;
  CartCubitEmpty({required this.message});
}
