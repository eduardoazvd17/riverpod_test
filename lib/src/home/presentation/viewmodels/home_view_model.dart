import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/src/home/domain/usecases/get_address_by_cep_usecase.dart';

import 'home_view_model_state.dart';

final homeViewModelProvider =
    StateNotifierProvider.autoDispose<HomeViewModel, HomeViewModelState>((ref) {
      return HomeViewModel(
        getAddressByCepUsecase: ref.read(getAddressByCepUsecaseProvider),
      );
    });

class HomeViewModel extends StateNotifier<HomeViewModelState> {
  final IGetAddressByCepUsecase getAddressByCepUsecase;
  HomeViewModel({required this.getAddressByCepUsecase})
    : super(HomeViewModelLoadedState());

  void resetState() => state = HomeViewModelLoadedState();

  Future<void> getAddressByCep(String cep) async {
    state = HomeViewModelLoadingState();
    final address = await getAddressByCepUsecase(cep);
    state = address == null
        ? HomeViewModelErrorState()
        : HomeViewModelLoadedState(address: address);
  }
}
