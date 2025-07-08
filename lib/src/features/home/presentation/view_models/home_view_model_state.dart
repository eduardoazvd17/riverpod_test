import 'package:riverpod_test/src/core/errors/failure.dart';
import 'package:riverpod_test/src/features/home/domain/entities/address_entity.dart';

sealed class HomeViewModelState {
  final AddressEntity? address;
  HomeViewModelState({this.address});
}

class HomeViewModelLoadedState extends HomeViewModelState {
  HomeViewModelLoadedState({required super.address});
}

class HomeViewModelLoadingState extends HomeViewModelState {}

class HomeViewModelErrorState extends HomeViewModelState {
  final Failure failure;
  HomeViewModelErrorState({required this.failure});
}
