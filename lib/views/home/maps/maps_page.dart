import 'package:flutter/material.dart';
import 'package:smart_jakarta/components/home_appbar.dart';

class MapsPage extends StatelessWidget {
  const MapsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: HomeAppBar(
        appBarTitle: 'Maps',
        userPictPath: 'assets/images/user_img_placeholder.png',
      ),
    );
  }
}
