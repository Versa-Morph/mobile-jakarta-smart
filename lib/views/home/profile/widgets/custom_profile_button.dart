import 'package:flutter/material.dart';

class CustomProfileButton extends StatelessWidget {
  const CustomProfileButton({
    super.key,
    required this.btnText,
    this.onTap,
  });
  final String btnText;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap ?? () {},
      style: TextButton.styleFrom(
          foregroundColor: Colors.orangeAccent,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          visualDensity: VisualDensity.compact,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          side: const BorderSide(
            color: Color(0xffDD9D3F),
            width: 2,
          )),
      child: Text(
        btnText,
        style: const TextStyle(
          color: Color(0xffDD9D3F),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
