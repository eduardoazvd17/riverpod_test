import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/src/home/presentation/viewmodels/home_view_model.dart';
import 'package:riverpod_test/src/home/presentation/viewmodels/home_view_model_state.dart';

class HomePageErrorWidget extends ConsumerWidget {
  const HomePageErrorWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeViewModel = ref.watch(homeViewModelProvider.notifier);
    final homeViewModelState = ref.watch(homeViewModelProvider);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text((homeViewModelState as HomeViewModelErrorState).failure.message),
          TextButton(
            onPressed: homeViewModel.resetState,
            child: const Text('Tentar novamente'),
          ),
        ],
      ),
    );
  }
}
