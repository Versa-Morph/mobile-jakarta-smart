import 'package:flutter/material.dart';
import 'package:smart_jakarta/views/login/widgets/content_header.dart';
import 'package:smart_jakarta/views/login/widgets/custom_button.dart';
import 'package:smart_jakarta/views/login/widgets/custom_divider.dart';
import 'package:smart_jakarta/views/login/widgets/custom_textfield.dart';
import 'package:smart_jakarta/views/login/widgets/sign_up_menu_button.dart';
import 'package:smart_jakarta/views/login/widgets/social_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isEmailSelected = true;

  void toggleMenu() {
    setState(() {
      isEmailSelected = !isEmailSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffafafa),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            const ContentHeader(),
            const SizedBox(height: 40),

            // Header text
            const Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xffD99022),
              ),
            ),
            const SizedBox(height: 15),

            const Text(
              'Please register to your account',
              style: TextStyle(
                color: Color(0xff6C6C6C),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20),

            // Row Menu
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SignUpMenuButton(
                    btnText: 'Email',
                    onTap: () => toggleMenu(),
                    borderColor: isEmailSelected
                        ? const Color(0xffD99022)
                        : const Color(0xffFAFAFA),
                    textColor: isEmailSelected
                        ? const Color(0xffD99022)
                        : const Color(0xff6C6C6C),
                  ),
                  SignUpMenuButton(
                    btnText: 'Phone',
                    onTap: () => toggleMenu(),
                    borderColor: isEmailSelected
                        ? const Color(0xffFAFAFA)
                        : const Color(0xffD99022),
                    textColor: isEmailSelected
                        ? const Color(0xff6C6C6C)
                        : const Color(0xffD99022),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Textfield
            CustomTextfield(
              controller: null, // TODO: ASSIGN CONTROLLER
              hintText: isEmailSelected ? 'Email' : 'Phone number',
              prefixImgPath: isEmailSelected
                  ? 'assets/icons/email_icon.png'
                  : 'assets/icons/phone_icon.png',
            ),

            const SizedBox(height: 15),

            // Button Signup
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: CustomButton(
                text: 'Sign Up',
                textColor: Colors.white,
                bgColor: const Color(0xFFD99022),
                onTap: () {
                  // TODO: IMPLEMENT ONTAP
                  Navigator.pushNamed(context, '/termOfUse');
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
              'Have an account?',
              style: TextStyle(
                color: Color(0xff6C6C6C),
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ),
            GestureDetector(
              onTap: () {
                // TODO: IMPLEMENT ONTAP
              },
              child: const Text(
                'Sign in',
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
