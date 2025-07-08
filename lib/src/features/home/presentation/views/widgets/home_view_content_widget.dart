import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zip_code_search/src/core/utils/formatters.dart';
import 'package:zip_code_search/src/features/home/presentation/view_models/home_view_model.dart';

class HomeViewContentWidget extends ConsumerStatefulWidget {
  const HomeViewContentWidget({super.key});

  @override
  ConsumerState<HomeViewContentWidget> createState() => _HomePageContentState();
}

class _HomePageContentState extends ConsumerState<HomeViewContentWidget> {
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
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          TextFormField(
            controller: _cepController,
            textAlign: TextAlign.center,
            inputFormatters: Formatters.cep,
            decoration: InputDecoration(
              hintText: 'Digite o CEP que deseja buscar...',
              alignLabelWithHint: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const Spacer(),
          if (homeViewModelState.address != null) ...[
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                homeViewModelState.address!.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(),
          ],
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).primaryColor,
                      ),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    onPressed: () {
                      homeViewModel.getAddressByCep(_cepController.text);
                    },
                    child: const Text('Buscar'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
