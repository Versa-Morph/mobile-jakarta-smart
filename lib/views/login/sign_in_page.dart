import 'package:flutter/material.dart';
import 'package:smart_jakarta/views/login/widgets/content_header.dart';
import 'package:smart_jakarta/views/login/widgets/custom_button.dart';
import 'package:smart_jakarta/views/login/widgets/custom_divider.dart';
import 'package:smart_jakarta/views/login/widgets/custom_textfield.dart';
import 'package:smart_jakarta/views/login/widgets/social_button.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            const ContentHeader(),
            const SizedBox(height: 40),
            // Header text
            const Text(
              'Welcome abroad',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xffD99022),
              ),
            ),
            const SizedBox(height: 15),

            const Text(
              'Please sign in to your account',
              style: TextStyle(
                color: Color(0xff6C6C6C),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),

            const SizedBox(height: 25),

            // Textfield
            const CustomTextfield(
              controller: null, // TODO: ASSIGN CONTROLLER
              hintText: 'Username/Email',
              prefixImgPath: 'assets/icons/email_icon.png',
            ),

            const SizedBox(height: 15),

            const CustomTextfield(
              controller: null, // TODO: ASSIGN CONTROLLER
              hintText: 'Password',
              prefixImgPath: 'assets/icons/pass_icon.png',
              obscureText: true,
            ),

            const SizedBox(height: 18),

            // Forgot Pass Text
            Padding(
              padding: const EdgeInsets.only(right: 55),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      // TODO: IMPLEMENT ONTAP FUNCTION
                    },
                    child: const Text(
                      'Forgot your password?',
                      style: TextStyle(
                        color: Color(0xffD99022),
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 15),

            // Button Signin
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: CustomButton(
                text: 'Sign In',
                textColor: Colors.white,
                bgColor: const Color(0xFFD99022),
                onTap: () {
                  // TODO: IMPLEMENT ONTAP
                },
              ),
            ),

            const SizedBox(height: 15),

            // Divider
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 60),
                child: CustomDivider()),

            const SizedBox(height: 15),

            // Social Media Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SocialButton(
                  imgPath: 'assets/icons/google_icon.png',
                  onTap: () {
                    // TODO: IMPLEMENT ONTAP
                  },
                ),
                SocialButton(
                  imgPath: 'assets/icons/apple_icon.png',
                  onTap: () {
                    // TODO: IMPLEMENT ONTAP
                  },
                ),
                SocialButton(
                  imgPath: 'assets/icons/fb_icon.png',
                  onTap: () {
                    // TODO: IMPLEMENT ONTAP
                  },
                ),
              ],
            ),

            const SizedBox(height: 120),

            // Sign Up Text
            const Text(
              'Don\'t have an account?',
              style: TextStyle(
                color: Color(0xff6C6C6C),
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/signUp');
              },
              child: const Text(
                'Register',
                style: TextStyle(
                  color: Color(0xffD99022),
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
