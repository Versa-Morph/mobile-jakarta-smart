import 'package:flutter/material.dart';
import 'package:smart_jakarta/components/home_appbar.dart';

class ProfilePageProvider extends StatelessWidget {
  const ProfilePageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: HomeAppBar(
        appBarTitle: 'Profile',
        userPictPath: 'assets/images/user_img_placeholder.png',
        isSettingsVisible: true,
      ),
    );
  }
}
