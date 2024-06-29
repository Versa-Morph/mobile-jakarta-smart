import 'package:flutter/material.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({
    super.key,
    required this.isVisible,
    required this.child,
  });
  final bool isVisible;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 6,
              offset: const Offset(0, 2), // shadow direction: bottom right
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
