import 'package:flutter/material.dart';

class HomeViewLoadingWidget extends StatelessWidget {
  const HomeViewLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Center(child: CircularProgressIndicator()));
  }
}
