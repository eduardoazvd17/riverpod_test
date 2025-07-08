import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zip_code_search/src/features/home/domain/usecases/get_address_by_cep_usecase.dart';

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
    : super(HomeViewModelLoadedState(address: null));

  void resetState() => state = HomeViewModelLoadedState(address: null);

  Future<void> getAddressByCep(String cep) async {
    state = HomeViewModelLoadingState();
    final result = await getAddressByCepUsecase(cep);
    state = result.fold(
      (failure) => HomeViewModelErrorState(failure: failure),
      (address) => HomeViewModelLoadedState(address: address),
    );
  }
}
