import 'package:flutter/material.dart';

class LandingPageError extends StatelessWidget {
  const LandingPageError({
    super.key,
    required this.errorMsg,
  });
  final String errorMsg;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.warning,
                  color: Colors.red,
                  size: 50,
                ),
                const SizedBox(height: 10),
                Text(errorMsg),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
