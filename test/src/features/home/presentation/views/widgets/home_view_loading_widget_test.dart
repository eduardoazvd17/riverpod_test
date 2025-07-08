import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zip_code_search/src/features/home/presentation/views/widgets/home_view_loading_widget.dart';

void main() {
  group('HomeViewLoadingWidget Tests', () {
    testWidgets('shoud render loading widget', (tester) async {
      //Act
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: const HomeViewLoadingWidget())),
      );

      //Assert
      expect(find.byType(SafeArea), findsOneWidget);
      expect(find.byType(Center), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
