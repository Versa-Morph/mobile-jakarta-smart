import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    required this.hintText,
    required this.prefixImgPath,
    this.obscureText,
    this.validator,
    this.onChanged,
  });
  final String prefixImgPath;
  final String hintText;
  final bool? obscureText;
  final String? Function(String? value)? validator;
  final Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45),
      child: TextFormField(
        onChanged: onChanged,
        validator: validator,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          fillColor: const Color(0xffF1F1F1),
          prefixIcon: Image.asset(
            prefixImgPath,
            color: const Color(0xffD99022),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xffF1F1F1),
            ),
            borderRadius: BorderRadius.circular(25),
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
    );
  }
}
