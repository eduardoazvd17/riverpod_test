import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_test/src/core/errors/failure.dart';
import 'package:riverpod_test/src/features/home/domain/entities/address_entity.dart';
import 'package:riverpod_test/src/features/home/domain/usecases/get_address_by_cep_usecase.dart';
import 'package:riverpod_test/src/features/home/presentation/view_models/home_view_model.dart';
import 'package:riverpod_test/src/features/home/presentation/view_models/home_view_model_state.dart';

class MockGetAddressByCepUsecase extends Mock
    implements IGetAddressByCepUsecase {}

void main() {
  late HomeViewModel viewModel;
  late IGetAddressByCepUsecase usecase;

  setUp(() {
    usecase = MockGetAddressByCepUsecase();
    viewModel = HomeViewModel(getAddressByCepUsecase: usecase);
  });

  group('HomeViewModel Tests', () {
    test(
      'should return a valid address when the response is successful',
      () async {
        //Arrange
        when(() => usecase(any())).thenAnswer((_) async {
          return Right(_mockAddress);
        });

        //Act
        await viewModel.getAddressByCep('12345-678');

        //Assert
        expect(viewModel.state, isA<HomeViewModelLoadedState>());
        expect(viewModel.state.address, _mockAddress);
      },
    );

    test(
      'should return a failure when the response is not successful',
      () async {
        //Arrange
        when(() => usecase(any())).thenAnswer((_) async {
          return Left(Failure(message: 'error message'));
        });

        //Act
        await viewModel.getAddressByCep('12345-678');

        //Assert
        expect(viewModel.state, isA<HomeViewModelErrorState>());
        final state = viewModel.state as HomeViewModelErrorState;
        expect(state.failure, isA<Failure>());
        expect(state.failure.message, 'error message');
      },
    );

    test(
      'should reset the state when the resetState method is called',
      () async {
        //Arrange
        viewModel.state = HomeViewModelErrorState(
          failure: Failure(message: 'error message'),
        );

        //Act
        viewModel.resetState();

        //Assert
        expect(viewModel.state, isA<HomeViewModelLoadedState>());
        expect(viewModel.state.address, null);
      },
    );
  });
}

final _mockAddress = AddressEntity(
  cep: '12345-678',
  address: 'Testing Street',
  neighborhood: 'Testing',
  city: 'Rio de Janeiro',
  state: 'RJ',
);
