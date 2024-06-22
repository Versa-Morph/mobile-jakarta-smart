import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_jakarta/views/login/widgets/content_header.dart';
import 'package:smart_jakarta/constant/constant.dart' as constant;
import 'package:smart_jakarta/views/login/widgets/custom_button.dart';

class TermOfUsePage extends StatefulWidget {
  const TermOfUsePage({super.key});

  @override
  State<TermOfUsePage> createState() => _TermOfUsePageState();
}

class _TermOfUsePageState extends State<TermOfUsePage> {
  bool isChecked = false;

  void toggleCheck(bool? value) {
    setState(() {
      isChecked = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Content Header
            const ContentHeader(),

            const SizedBox(height: 40),

            const Text(
              'Terms of Use',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xffD99022),
              ),
            ),

            const SizedBox(height: 15),

            // Terms Message
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.355,
                child: const SingleChildScrollView(
                  child: Text(
                    constant.AGGREMENT_MESSAGE,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Color(0xff6C6C6C),
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Checkbox Aggrement
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 27),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(value: isChecked, onChanged: toggleCheck),
                  Expanded(
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xff6C6C6C),
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(text: 'I hereby agree to the '),
                          TextSpan(
                            text: 'Terms and Conditions ',
                            style: TextStyle(
                              color: Color(0xffD99022),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(text: 'and Privacy Policy of '),
                          TextSpan(
                            text: 'Smart Jakarta ',
                            style: TextStyle(
                              color: Color(0xffD99022),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Continue Button

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: CustomButton(
                text: 'Continue',
                textColor: isChecked ? Colors.white : Colors.grey,
                bgColor: const Color(0xFFD99022),
                borderColor: isChecked ? const Color(0xFFD99022) : Colors.white,
                onTap: isChecked ? () {} : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
