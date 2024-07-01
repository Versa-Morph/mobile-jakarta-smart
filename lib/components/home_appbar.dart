import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_jakarta/cubit/theme_cubit/theme_cubit.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    required this.appBarTitle,
    required this.userPictPath,
    this.isSettingsVisible = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final String appBarTitle;
  final String userPictPath;
  final bool isSettingsVisible;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      scrolledUnderElevation: 0.0,
      title: Text(
        appBarTitle,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      leading: BlocBuilder<ThemeCubit, ThemeState>(
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
      actions: [
        // TODO: IMPLEMENT PROPER IMAGE

        (isSettingsVisible)
            ? Padding(
                padding: const EdgeInsets.only(right: 25),
                child: IconButton(
                  onPressed: () {
                    //TODO: IMPLEMENT ONPRESSED
                  },
                  icon: const Icon(
                    Icons.settings_outlined,
                    color: Colors.grey,
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(right: 25),
                child: Hero(
                  tag: 'userPict',
                  child: CircleAvatar(
                    backgroundImage: AssetImage(userPictPath),
                  ),
                ),
              ),
      ],
    );
  }
}
