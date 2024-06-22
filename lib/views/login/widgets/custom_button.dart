import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.textColor,
    required this.bgColor,
    this.borderColor,
    this.onTap,
  });
  final String text;
  final Color bgColor;
  final Color? borderColor;
  final Color textColor;

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: Color(0xffC7C7C7),
          backgroundColor: bgColor,
          side: BorderSide(
            color: borderColor ?? const Color(0xffD99022),
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
