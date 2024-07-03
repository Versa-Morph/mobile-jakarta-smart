import 'package:flutter/material.dart';
import 'package:smart_jakarta/components/home_appbar.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
          appBarTitle: 'Contact',
          userPictPath: 'assets/images/user_img_placeholder.png'),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {},
          child: Icon(Icons.abc),
        ),
      ),
    );
  }
}
