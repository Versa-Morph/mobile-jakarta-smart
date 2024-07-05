import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_jakarta/cubit/theme_cubit/theme_cubit.dart';

class CustomProfileText extends StatelessWidget {
  const CustomProfileText({
    super.key,
    required this.text,
    this.fontSize,
  });
  final String text;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        color: context.read<ThemeCubit>().state.themeData == ThemeData.dark()
            ? Colors.white
            : const Color(0xffA39E9E),
      ),
    );
  }
}
