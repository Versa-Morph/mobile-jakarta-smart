import 'package:flutter/material.dart';

class IncidentTextField extends StatelessWidget {
  const IncidentTextField({
    super.key,
    required this.labelText,
    required this.enabled,
    this.validator,
    this.controller,
  });
  final String labelText;
  final bool enabled;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      validator: validator,
      maxLines: (enabled) ? null : 1,
      keyboardType: (enabled) ? TextInputType.multiline : TextInputType.text,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.black54,
        ),
        floatingLabelStyle: const TextStyle(
          fontSize: 20,
          color: Colors.black54,
        ),
        border: InputBorder.none,
        fillColor: const Color(0xffF1F1F1),
        contentPadding: const EdgeInsets.all(10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
