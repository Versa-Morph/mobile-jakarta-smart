import 'package:flutter/material.dart';
import 'package:smart_jakarta/components/home_appbar.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: HomeAppBar(
        appBarTitle: 'Home',
        userPictPath: 'assets/images/user_img_placeholder.png',
      ),
    );
  }
}
