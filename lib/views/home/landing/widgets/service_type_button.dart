import 'package:flutter/material.dart';

class ServiceTypeButton extends StatelessWidget {
  const ServiceTypeButton({
    super.key,
    required this.title,
    required this.serviceImagePath,
    this.onTap,
  });

  final String title;
  final String serviceImagePath;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xffD99022),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : const Color(0xff2C2828)),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(
                    Icons.arrow_forward,
                    color: Color(0xffD99022),
                  ),
                  ImageIcon(
                    AssetImage(
                      serviceImagePath,
                    ),
                    color: const Color(0xffA39E9E),
                    size: 25,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
