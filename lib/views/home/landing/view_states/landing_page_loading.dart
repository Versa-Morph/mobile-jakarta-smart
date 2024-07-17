import 'package:flutter/material.dart';

class LandingPageLoading extends StatelessWidget {
  const LandingPageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
