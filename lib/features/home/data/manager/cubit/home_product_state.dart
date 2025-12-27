part of 'home_product_cubit.dart';

sealed class HomeProductState {}

final class HomeProductInitial extends HomeProductState {}

final class HomeProductLoading extends HomeProductState {}

final class HomeProductLoaded extends HomeProductState {
  final List<Product> products;
  HomeProductLoaded(this.products);
}

final class HomeProductError extends HomeProductState {
  final String message;
  HomeProductError(this.message);
}
