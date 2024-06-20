import 'package:flutter/material.dart';

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xffF1F1F1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Image.asset('assets/icons/email_icon.png'),
                    contentPadding: const EdgeInsets.all(10),
                    hintText: 'Username/Email',
                    hintStyle: const TextStyle(
                        color: Color(0xffC5C8C9),
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                    border: InputBorder.none,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
