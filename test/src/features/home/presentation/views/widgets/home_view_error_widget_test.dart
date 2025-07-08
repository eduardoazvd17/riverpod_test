import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zip_code_search/src/core/errors/failure.dart';
import 'package:zip_code_search/src/features/home/domain/usecases/get_address_by_cep_usecase.dart';
import 'package:zip_code_search/src/features/home/presentation/view_models/home_view_model.dart';
import 'package:zip_code_search/src/features/home/presentation/view_models/home_view_model_state.dart';
import 'package:zip_code_search/src/features/home/presentation/views/widgets/home_view_error_widget.dart';

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
    testWidgets('shoud render error message with try again button', (
      tester,
    ) async {
      //Arrange
      viewModel.state = HomeViewModelErrorState(
        failure: Failure(message: 'error message'),
      );

      //Act
      await tester.pumpWidget(
        ProviderScope(
          overrides: [homeViewModelProvider.overrideWith((_) => viewModel)],
          child: MaterialApp(home: Scaffold(body: HomeViewErrorWidget())),
        ),
      );

      //Assert
      expect(find.text('error message'), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
    });
  });
}
