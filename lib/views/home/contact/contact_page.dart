import 'package:flutter/material.dart';
import 'package:smart_jakarta/components/home_appbar.dart';
import 'package:smart_jakarta/utility/lauch_call.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(
          appBarTitle: 'Contact',
          userPictPath: 'assets/images/user_img_placeholder.png'),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            LaunchCall launchCall = LaunchCall();
            await launchCall.makeCall('123');
          },
          child: const Icon(Icons.abc),
        ),
      ),
    );
  }
}
