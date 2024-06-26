import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_jakarta/components/home_appbar.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(
        appBarTitle: 'Home',
        userPictPath: 'assets/images/user_img_placeholder.png',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Header
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 10,
              ),
              decoration: const BoxDecoration(
                color: Color(0xffffffff),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text(
                    'Hello, ',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                          child: Text(
                        'Your Location',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                      Expanded(
                        child: Text(
                          'Senayan, Jakarta Selatan',
                          style: TextStyle(
                              color: Color(0xffD99022),
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Header Text
            const SizedBox(height: 25),

            const Text(
              'An Emergency?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Color(0xff36393C),
              ),
            ),
            const SizedBox(height: 10),

            const Text(
              'Just hold the button to call',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xffa39e9e),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
