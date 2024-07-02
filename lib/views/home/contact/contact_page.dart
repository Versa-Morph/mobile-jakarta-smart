import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smart_jakarta/components/home_appbar.dart';
import 'package:smart_jakarta/network/api.dart';

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
          onPressed: () async {
            var data = {'email': 'sahri@gmail.com', 'password': 'sahri123'};
            final res = await Network().auth(data, '/login');
            final resBody = jsonDecode(res.body);
            print(resBody);
          },
          child: Icon(Icons.abc),
        ),
      ),
    );
  }
}
