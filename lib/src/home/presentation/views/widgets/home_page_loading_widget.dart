import 'package:flutter/material.dart';

class HomePageLoadingWidget extends StatelessWidget {
  const HomePageLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Center(child: CircularProgressIndicator()));
  }
}
