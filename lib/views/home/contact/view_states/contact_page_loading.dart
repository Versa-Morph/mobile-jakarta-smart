import 'package:flutter/material.dart';

class ContactPageLoading extends StatelessWidget {
  const ContactPageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
