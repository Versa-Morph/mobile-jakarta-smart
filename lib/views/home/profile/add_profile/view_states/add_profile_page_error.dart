import 'package:flutter/material.dart';

class AddProfilePageError extends StatelessWidget {
  const AddProfilePageError({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning,
                  color: Colors.red,
                  size: 50,
                ),
                SizedBox(height: 10),
                Text('Uh Oh, Somethings Wrong, Please Refresh The App'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
