import 'package:flutter/material.dart';

class SignUpMenuButton extends StatelessWidget {
  const SignUpMenuButton({
    super.key,
    required this.btnText,
    required this.borderColor,
    required this.textColor,
    this.onTap,
  });
  final Function()? onTap;
  final String btnText;
  final Color borderColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        width: 130,
        height: 25,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: borderColor,
            ),
          ),
        ),
        child: Center(
          child: Text(
            btnText,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
