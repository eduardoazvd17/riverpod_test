import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/src/home/presentation/viewmodels/home_view_model.dart';
import 'package:riverpod_test/src/home/presentation/viewmodels/home_view_model_state.dart';
import 'package:riverpod_test/src/home/presentation/views/widgets/home_page_content_widget.dart';
import 'package:riverpod_test/src/home/presentation/views/widgets/home_page_error_widget.dart';
import 'package:riverpod_test/src/home/presentation/views/widgets/home_page_loading_widget.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeViewModelState = ref.watch(homeViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Buscador de CEP')),
      body: switch (homeViewModelState) {
        HomeViewModelLoadedState() => const HomePageContentWidget(),
        HomeViewModelErrorState() => const HomePageErrorWidget(),
        _ => const HomePageLoadingWidget(),
      },
    );
  }
}
