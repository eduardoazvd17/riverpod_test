import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zip_code_search/src/core/errors/failure.dart';
import 'package:zip_code_search/src/features/home/domain/usecases/get_address_by_cep_usecase.dart';
import 'package:zip_code_search/src/features/home/presentation/view_models/home_view_model.dart';
import 'package:zip_code_search/src/features/home/presentation/view_models/home_view_model_state.dart';
import 'package:zip_code_search/src/features/home/presentation/views/home_view.dart';
import 'package:zip_code_search/src/features/home/presentation/views/widgets/home_view_content_widget.dart';
import 'package:zip_code_search/src/features/home/presentation/views/widgets/home_view_error_widget.dart';
import 'package:zip_code_search/src/features/home/presentation/views/widgets/home_view_loading_widget.dart';

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
          child: MaterialApp(home: HomeView()),
        ),
      );

      //Assert
      expect(find.text('Buscador de CEP'), findsOneWidget);
      expect(find.byType(HomeViewContentWidget), findsOneWidget);
    });

    testWidgets('shoud render loading state', (tester) async {
      //Act
      viewModel.state = HomeViewModelLoadingState();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [homeViewModelProvider.overrideWith((_) => viewModel)],
          child: MaterialApp(home: HomeView()),
        ),
      );

      //Assert
      expect(find.text('Buscador de CEP'), findsOneWidget);
      expect(find.byType(HomeViewLoadingWidget), findsOneWidget);
    });

    testWidgets('shoud render error state', (tester) async {
      //Act
      viewModel.state = HomeViewModelErrorState(
        failure: Failure(message: 'Erro ao buscar CEP'),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [homeViewModelProvider.overrideWith((_) => viewModel)],
          child: MaterialApp(home: HomeView()),
        ),
      );

      //Assert
      expect(find.text('Buscador de CEP'), findsOneWidget);
      expect(find.byType(HomeViewErrorWidget), findsOneWidget);
    });
  });
}
