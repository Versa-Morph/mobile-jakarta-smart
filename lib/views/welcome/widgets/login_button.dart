import 'package:flutter/material.dart';

class LoginButon extends StatelessWidget {
  const LoginButon({
    super.key,
    required this.text,
    required this.textColor,
    required this.bgColor,
    this.onTap,
  });
  final String text;
  final Color bgColor;
  final Color textColor;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 150,
      child: ElevatedButton(
        onPressed: onTap ?? () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          side: const BorderSide(
            color: Color(0xffD99022),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
