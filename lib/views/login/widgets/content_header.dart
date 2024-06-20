import 'package:flutter/material.dart';

class ContentHeader extends StatelessWidget {
  const ContentHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/app_background.png'),
        ),
      ),
      child: Center(
        child: Image.asset(
          'assets/icons/app_logo_large.png',
        ),
      ),
    );
  }
}
