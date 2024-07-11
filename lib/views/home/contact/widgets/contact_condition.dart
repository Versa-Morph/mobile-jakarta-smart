import 'package:flutter/material.dart';

class ContactCondition extends StatelessWidget {
  const ContactCondition({
    super.key,
    required this.text,
    this.isDanger = false,
  });
  final String text;
  final bool isDanger;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: const Color(0xfff9ebeb),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isDanger ? Colors.red : const Color(0xff3BC273),
          fontSize: 13,
        ),
      ),
    );
  }
}
