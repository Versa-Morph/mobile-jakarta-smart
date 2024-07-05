import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_jakarta/models/user_bio.dart';
import 'package:smart_jakarta/utility/string_capitalize.dart';
import 'package:smart_jakarta/views/home/profile/widgets/custom_profile_button.dart';
import 'package:smart_jakarta/views/home/profile/widgets/custom_profile_text.dart';

class ProfilePageLoaded extends StatelessWidget {
  const ProfilePageLoaded({super.key, required this.userBio});
  final UserBio userBio;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10),

          // Profile Pict
          Center(
            child: CircleAvatar(
              radius: 50,
              foregroundImage: NetworkImage(
                userBio.profilePictPath,
              ),
              backgroundImage: const AssetImage(
                'assets/images/placeholder_image_large.png',
              ),
              backgroundColor: Colors.black12,
            ),
          ),

          const SizedBox(height: 15),

          // User Data
          Text(
            userBio.fullName.capitalize(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 5),

          CustomProfileText(text: userBio.nik),
          CustomProfileText(
            text:
                '${userBio.nickname.capitalize()} | ${userBio.city.capitalize()}',
          ),
          CustomProfileText(text: userBio.address.capitalize()),

          const SizedBox(height: 15),

          // Button Edit Profile
          const CustomProfileButton(btnText: 'Edit Profile'),

          const SizedBox(height: 20),

          // User Information Grid

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                children: [
                  Text(userBio.fullName),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
