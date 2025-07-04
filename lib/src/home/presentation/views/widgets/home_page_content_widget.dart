import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/src/core/utils/formatters.dart';
import 'package:riverpod_test/src/home/presentation/viewmodels/home_view_model.dart';

class HomePageContentWidget extends ConsumerStatefulWidget {
  const HomePageContentWidget({super.key});

  @override
  ConsumerState<HomePageContentWidget> createState() => _HomePageContentState();
}

class _HomePageContentState extends ConsumerState<HomePageContentWidget> {
  late final TextEditingController _cepController;

  @override
  void initState() {
    _cepController = TextEditingController(
      text: ref.read(homeViewModelProvider).address?.cep,
    );
    super.initState();
  }

  @override
  void dispose() {
    _cepController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModelState = ref.watch(homeViewModelProvider);
    final homeViewModel = ref.watch(homeViewModelProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          TextFormField(
            controller: _cepController,
            textAlign: TextAlign.center,
            inputFormatters: Formatters.cep,
            decoration: const InputDecoration(
              hintText: 'Digite o CEP que deseja buscar...',
              alignLabelWithHint: true,
            ),
          ),
          const Spacer(),
          if (homeViewModelState.address != null) ...[
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                homeViewModelState.address!.toString(),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
          ],
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    homeViewModel.getAddressByCep(_cepController.text);
                  },
                  child: const Text('Buscar'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
