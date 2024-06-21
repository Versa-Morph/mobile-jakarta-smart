import 'package:flutter/material.dart';

class MissingPage extends StatelessWidget {
  const MissingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '404',
              style: TextStyle(fontSize: 28),
            ),
            Text(
              'Page Not Found !',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
