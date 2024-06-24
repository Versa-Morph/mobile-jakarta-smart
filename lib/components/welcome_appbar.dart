import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_jakarta/bloc/cubit/theme_cubit.dart';

class WelcomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WelcomeAppBar({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    state.themeData == ThemeData.dark()
                        ? 'assets/images/app_logo_white.png'
                        : 'assets/images/app_logo.png',
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            );
          },
        ),
        actions: [
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(left: 25),
                child: IconButton(
                  onPressed: () {
                    context.read<ThemeCubit>().toggleTheme();
                  },
                  icon: ImageIcon(
                    const AssetImage('assets/icons/moon_icon.png'),
                    size: 20,
                    color: context.read<ThemeCubit>().state.themeData ==
                            ThemeData.dark()
                        ? Colors.amber
                        : const Color(0xffA39E9E),
                  ),
                ),
              );
            },
          ),
        ]);
  }
}
