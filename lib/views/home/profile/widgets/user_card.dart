import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_jakarta/cubit/theme_cubit/theme_cubit.dart';
import 'package:smart_jakarta/views/home/profile/widgets/custom_profile_text.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.title,
    required this.userData,
    required this.subtitle,
    required this.iconPath,
  });
  final String title;
  final String userData;
  final String subtitle;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xffEAECEB),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomProfileText(
                text: title,
                fontSize: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    userData,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: context.read<ThemeCubit>().state.themeData ==
                              ThemeData.dark()
                          ? Colors.white
                          : const Color(0xff2C2828),
                    ),
                  ),
                  CustomProfileText(
                    text: subtitle,
                  ),
                ],
              )
            ],
          ),
          Expanded(
            child: ImageIcon(
              AssetImage(
                iconPath,
              ),
              color: const Color(0xffDD9E3E),
            ),
          ),
        ],
      ),
    );
  }
}
