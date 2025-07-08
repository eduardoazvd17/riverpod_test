import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zip_code_search/src/features/home/presentation/view_models/home_view_model.dart';
import 'package:zip_code_search/src/features/home/presentation/view_models/home_view_model_state.dart';
import 'package:zip_code_search/src/features/home/presentation/views/widgets/home_view_content_widget.dart';
import 'package:zip_code_search/src/features/home/presentation/views/widgets/home_view_error_widget.dart';
import 'package:zip_code_search/src/features/home/presentation/views/widgets/home_view_loading_widget.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeViewModelState = ref.watch(homeViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Buscador de CEP')),
      body: switch (homeViewModelState) {
        HomeViewModelLoadedState() => const HomeViewContentWidget(),
        HomeViewModelErrorState() => const HomeViewErrorWidget(),
        _ => const HomeViewLoadingWidget(),
      },
    );
  }
}
