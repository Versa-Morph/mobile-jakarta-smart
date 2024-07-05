import 'package:flutter/material.dart';
import 'package:smart_jakarta/views/home/profile/widgets/custom_profile_button.dart';

class ProfilePageEmpty extends StatelessWidget {
  const ProfilePageEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/images/search_userbio.png',
              color: const Color(0xffDD9D3F).withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Uh Oh !',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Looks like you haven\'t completed your profile yet, click here to complete your profile',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),

          const SizedBox(height: 20),

          // Button Update Profile
          CustomProfileButton(
            btnText: 'Complete Profile',
            onTap: () {
              // TODO: IMPLEMENT ONTAP
            },
          ),
        ],
      ),
    );
  }
}
