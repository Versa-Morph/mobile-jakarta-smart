import 'package:flutter/material.dart';

class EmergencyButton extends StatelessWidget {
  const EmergencyButton({
    super.key,
    this.onLongPress,
  });
  final Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress ?? () {},
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
