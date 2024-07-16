import 'package:flutter/material.dart';
import 'package:smart_jakarta/local_env.dart';
import 'package:smart_jakarta/models/user_bio.dart';
import 'package:smart_jakarta/utility/string_capitalize.dart';
import 'package:smart_jakarta/views/home/profile/widgets/custom_profile_button.dart';
import 'package:smart_jakarta/views/home/profile/widgets/custom_profile_text.dart';
import 'package:smart_jakarta/views/home/profile/widgets/user_card.dart';

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
                '$API_URL/${userBio.profilePictPath}',
              ),
              backgroundImage: const AssetImage(
                'assets/images/placeholder_image_large.png',
              ),
              onForegroundImageError: (exception, stackTrace) {},
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

          // User Information Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: UserCard(
                              title: 'Age',
                              userData: userBio.age.toString(),
                              subtitle: ' Years',
                              iconPath: 'assets/icons/user_age_icon.png',
                            ),
                          ),
                          const SizedBox(height: 14),
                          Expanded(
                            child: UserCard(
                              title: 'Height',
                              userData: userBio.height.toString(),
                              subtitle: ' cm',
                              iconPath: 'assets/icons/heigth_icon.png',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: UserCard(
                                title: 'Blood Type',
                                userData: userBio.bloodType,
                                subtitle: ' group',
                                iconPath: 'assets/icons/blood_icon.png'),
                          ),
                          const SizedBox(height: 14),
                          Expanded(
                            child: UserCard(
                                title: 'Weigth',
                                userData: userBio.weight.toString(),
                                subtitle: ' kg',
                                iconPath: 'assets/icons/weigth_icon.png'),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
