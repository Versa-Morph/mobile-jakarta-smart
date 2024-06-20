import 'package:flutter/material.dart';
import 'package:smart_jakarta/components/welcome_appbar.dart';
import 'package:smart_jakarta/views/welcome/widgets/content_feature.dart';
import 'package:smart_jakarta/views/welcome/widgets/login_button.dart';
import 'package:smart_jakarta/views/welcome/widgets/typewriter_text.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      appBar: const WelcomeAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Center(
          child: Column(
            children: [
              // Header Text
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 200,
                child: const TypewriterText(),
              ),

              const SizedBox(height: 45),

              // Content feature 1
              const ContentFeature(
                  leadingImagePath: 'assets/icons/icon1.png',
                  contentText: [
                    TextSpan(
                      text: 'Location reporting ',
                      style: TextStyle(
                        color: Color(0xffD99022),
                      ),
                    ),
                    TextSpan(text: 'feature makes it easy for '),
                    TextSpan(
                      text: 'citizens ',
                      style: TextStyle(
                        color: Color(0xffD99022),
                      ),
                    ),
                    TextSpan(text: 'to report '),
                    TextSpan(
                      text: 'issues',
                      style: TextStyle(
                        color: Color(0xffD99022),
                      ),
                    ),
                  ]),

              const SizedBox(height: 16),

              // Content feature 2
              const ContentFeature(
                leadingImagePath: 'assets/icons/icon2.png',
                contentText: [
                  TextSpan(
                    text: 'Provides ',
                    style: TextStyle(
                      color: Color(0xffD99022),
                    ),
                  ),
                  TextSpan(text: 'real-time '),
                  TextSpan(
                    text: 'information ',
                    style: TextStyle(
                      color: Color(0xffD99022),
                    ),
                  ),
                  TextSpan(text: 'on '),
                  TextSpan(
                    text: 'traffic ',
                    style: TextStyle(
                      color: Color(0xffD99022),
                    ),
                  ),
                  TextSpan(text: 'and public '),
                  TextSpan(
                    text: 'transportation',
                    style: TextStyle(
                      color: Color(0xffD99022),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Content feature 3
              const ContentFeature(
                leadingImagePath: 'assets/icons/icon3.png',
                contentText: [
                  TextSpan(
                    text: 'Emergency ',
                    style: TextStyle(
                      color: Color(0xffD99022),
                    ),
                  ),
                  TextSpan(text: 'services and '),
                  TextSpan(
                    text: 'local events ',
                    style: TextStyle(
                      color: Color(0xffD99022),
                    ),
                  ),
                  TextSpan(text: 'info ensure '),
                  TextSpan(
                    text: 'quick response',
                    style: TextStyle(
                      color: Color(0xffD99022),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 60),

              // SignIn/Up Button
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  LoginButon(
                    text: 'Login',
                    textColor: Color(0xffffffff),
                    bgColor: Color(0xffD99022),
                  ),
                  LoginButon(
                    text: 'Sign up',
                    textColor: Color(0xffD99022),
                    bgColor: Color(0xffffffff),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
