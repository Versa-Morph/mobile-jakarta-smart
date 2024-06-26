import 'package:flutter/material.dart';

class EmergencyButton extends StatelessWidget {
  const EmergencyButton({
    super.key,
    this.onTap,
  });
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        height: 125,
        width: 125,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xffD99022),
        ),
        child: const Icon(
          Icons.call,
          size: 50,
          color: Colors.white,
        ),
      ),
    );
  }
}
