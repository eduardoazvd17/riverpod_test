import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_test/src/features/home/domain/entities/address_entity.dart';
import 'package:riverpod_test/src/features/home/domain/usecases/get_address_by_cep_usecase.dart';
import 'package:riverpod_test/src/features/home/presentation/view_models/home_view_model.dart';
import 'package:riverpod_test/src/features/home/presentation/view_models/home_view_model_state.dart';
import 'package:riverpod_test/src/features/home/presentation/views/widgets/home_view_content_widget.dart';

class MockGetAddressByCepUsecase extends Mock
    implements IGetAddressByCepUsecase {}

void main() {
  late IGetAddressByCepUsecase usecase;
  late HomeViewModel viewModel;

  setUp(() {
    usecase = MockGetAddressByCepUsecase();
    viewModel = HomeViewModel(getAddressByCepUsecase: usecase);
  });

  group('HomeView Tests', () {
    testWidgets('shoud render initial state without address data', (
      tester,
    ) async {
      //Act
      await tester.pumpWidget(
        ProviderScope(
          overrides: [homeViewModelProvider.overrideWith((_) => viewModel)],
          child: MaterialApp(home: Scaffold(body: HomeViewContentWidget())),
        ),
      );

      //Assert
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('shoud search address on enter text and tap on button', (
      tester,
    ) async {
      //Arrange
      when(() => usecase(any())).thenAnswer((_) async => Right(_mockAddress));

      //Act
      await tester.pumpWidget(
        ProviderScope(
          overrides: [homeViewModelProvider.overrideWith((_) => viewModel)],
          child: MaterialApp(home: Scaffold(body: HomeViewContentWidget())),
        ),
      );

      //Act
      await tester.enterText(find.byType(TextFormField), '12345-678');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      //Assert
      verify(() => usecase.call('12345-678')).called(1);
      expect(find.text(_mockAddress.toString()), findsOneWidget);
    });

    testWidgets('shoud render address search result', (tester) async {
      //Act
      viewModel.state = HomeViewModelLoadedState(address: _mockAddress);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [homeViewModelProvider.overrideWith((_) => viewModel)],
          child: MaterialApp(home: Scaffold(body: HomeViewContentWidget())),
        ),
      );

      //Assert
      expect(find.text(_mockAddress.toString()), findsOneWidget);
    });
  });
}

final _mockAddress = AddressEntity(
  cep: '12345-678',
  address: 'Testing Street',
  neighborhood: 'Testing',
  city: 'Rio de Janeiro',
  state: 'RJ',
);
