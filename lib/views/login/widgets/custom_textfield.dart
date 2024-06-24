import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    required this.hintText,
    required this.prefixImgPath,
    this.controller,
    this.obscureText,
  });
  final String prefixImgPath;
  final String hintText;
  final TextEditingController? controller;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffF1F1F1),
          borderRadius: BorderRadius.circular(25),
        ),
        child: TextField(
          controller: controller,
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
            prefixIcon: Image.asset(
              prefixImgPath,
              color: const Color(0xffD99022),
            ),
            contentPadding: const EdgeInsets.all(10),
            hintText: hintText,
            hintStyle: const TextStyle(
                color: Color(0xffC5C8C9),
                fontSize: 13,
                fontWeight: FontWeight.w400),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
