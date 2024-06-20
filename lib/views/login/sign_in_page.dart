import 'package:flutter/material.dart';
import 'package:smart_jakarta/views/login/widgets/custom_button.dart';
import 'package:smart_jakarta/views/login/widgets/custom_textfield.dart';
import 'package:smart_jakarta/views/login/widgets/social_button.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffafafa),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              height: MediaQuery.of(context).size.height / 3,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/app_background.png'),
                ),
              ),
              child: Center(
                child: Image.asset(
                  'assets/icons/app_logo_large.png',
                ),
              ),
            ),

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
              hintText: 'Username/Email',
              prefixImgPath: 'assets/icons/email_icon.png',
            ),

            const SizedBox(height: 15),

            const CustomTextfield(
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
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: CustomButton(
                text: 'Sign In',
                textColor: Colors.white,
                bgColor: Color(0xFFD99022),
                onTap: () {
                  // TODO: IMPLEMENT ONTAP
                },
              ),
            ),

            const SizedBox(height: 15),

            // Divider
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: const Divider(
                        color: Color(0xffD99022),
                      ),
                    ),
                  ),
                  const Text(
                    'Or continue with',
                    style: TextStyle(
                      color: Color(0xffD99022),
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: const Divider(
                        color: Color(0xffD99022),
                      ),
                    ),
                  ),
                ],
              ),
            ),

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
                // TODO: IMPLEMENT ONTAP
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
