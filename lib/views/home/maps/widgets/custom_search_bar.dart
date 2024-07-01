import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_jakarta/cubit/theme_cubit/theme_cubit.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    this.controller,
    this.onChanged,
  });
  final TextEditingController? controller;
  final Function(String query)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          style: TextStyle(
            color:
                context.read<ThemeCubit>().state.themeData == ThemeData.dark()
                    ? Colors.white
                    : Colors.black,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            hintText: 'What do you want to find?',
            hintStyle: TextStyle(
              color:
                  context.read<ThemeCubit>().state.themeData == ThemeData.dark()
                      ? Colors.white
                      : const Color(0xffA39E9E),
            ),
            suffixIcon: const Icon(
              Icons.search,
              size: 30,
            ),
            suffixIconColor:
                context.read<ThemeCubit>().state.themeData == ThemeData.dark()
                    ? Colors.white
                    : const Color(0xffA39E9E),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
