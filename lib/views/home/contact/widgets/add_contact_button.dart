import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_jakarta/cubit/theme_cubit/theme_cubit.dart';

class AddContactButton extends StatelessWidget {
  const AddContactButton({
    super.key,
    this.onTap,
  });
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.black12,
      title: Text(
        'Add more',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: context.read<ThemeCubit>().state.themeData == ThemeData.dark()
              ? Colors.white
              : const Color(0xff2C2828),
        ),
      ),
      subtitle: Text(
        'contact',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: context.read<ThemeCubit>().state.themeData == ThemeData.dark()
              ? Colors.white
              : const Color(0xffA39E9E),
        ),
      ),
      leading: const CircleAvatar(
        radius: 40,
        backgroundColor: Color(0xffEC6461),
        child: Icon(
          Icons.add,
          size: 35,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 16,
      ),
      onTap: onTap ?? () {},
    );
  }
}
