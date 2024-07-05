import 'package:flutter/material.dart';

class ProfilePageLoading extends StatelessWidget {
  const ProfilePageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
