part of 'add_and_remove_cubit.dart';

sealed class AddState {}

final class AddInitial extends AddState {}

final class AddLoading extends AddState {}

final class AddSuccess extends AddState {
  final AddAndRemoveModel response;
  AddSuccess({required this.response});
}

final class AddFailure extends AddState {
  final String error;
  AddFailure({required this.error});
}

sealed class RemoveState {}

final class RemoveInitial extends RemoveState {}

final class RemoveLoading extends RemoveState {}

final class RemoveSuccess extends RemoveState {
  final AddAndRemoveModel response;
  RemoveSuccess({required this.response});
}

final class RemoveFailure extends RemoveState {
  final String error;
  RemoveFailure({required this.error});
}
