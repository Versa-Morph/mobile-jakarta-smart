import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 20),
            child: const Divider(
              color: Color(0xffD99022),
            ),
          ),
        ),
        const Text(
          'Or continue with',
          style: TextStyle(
            color: Color(0xffD99022),
            fontSize: 11,
            fontWeight: FontWeight.w400,
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 20),
            child: const Divider(
              color: Color(0xffD99022),
            ),
          ),
        ),
      ],
    );
  }
}
