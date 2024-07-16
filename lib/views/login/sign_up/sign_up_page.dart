import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_jakarta/utility/validators.dart';
import 'package:smart_jakarta/views/login/sign_up/cubit/sign_up_cubit.dart';
import 'package:smart_jakarta/views/login/widgets/content_header.dart';
import 'package:smart_jakarta/components/custom_button.dart';
import 'package:smart_jakarta/views/login/widgets/custom_divider.dart';
import 'package:smart_jakarta/views/login/widgets/custom_textfield.dart';
import 'package:smart_jakarta/views/login/widgets/sign_up_menu_button.dart';
import 'package:smart_jakarta/views/login/widgets/social_button.dart';

class SignUpPageProvider extends StatelessWidget {
  const SignUpPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: const SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isEmailSelected = true;
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
  }

  void toggleMenu() {
    setState(() {
      isEmailSelected = !isEmailSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSucces) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/termOfUse', (route) => false);
          } else if (state is SignUpError) {
            final snackBar = SnackBar(
              content: Text(state.errorMsg),
              duration: const Duration(seconds: 1),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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

                // Textfield username
                CustomTextfield(
                  hintText: 'Username',
                  textController: _usernameController,
                  prefixImgPath: 'assets/icons/profile_icon.png',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Your Username';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),

                // Textfield Email
                CustomTextfield(
                  hintText: isEmailSelected ? 'Email' : 'Phone number',
                  textController: _emailController,
                  prefixImgPath: isEmailSelected
                      ? 'assets/icons/email_icon.png'
                      : 'assets/icons/phone_icon.png',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter An Email';
                    } else if (!value.contains('@')) {
                      return 'Email is not correct';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),

                isEmailSelected
                    ? Column(
                        children: [
                          // Textfield Password
                          CustomTextfield(
                            hintText: 'Password',
                            textController: _passwordController,
                            prefixImgPath: 'assets/icons/pass_icon.png',
                            obscureText: true,
                            validator: (value) =>
                                Validators.validatePassword(value),
                          ),

                          const SizedBox(height: 15),

                          // Textfield Password
                          CustomTextfield(
                              textController: _rePasswordController,
                              hintText: 'Re-Type Password',
                              prefixImgPath: 'assets/icons/pass_icon.png',
                              obscureText: true,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value != _passwordController.text) {
                                  return 'Password do not match';
                                }
                                return null;
                              }),
                        ],
                      )
                    : const SizedBox(),

                const SizedBox(height: 15),

                // Button Signup
                BlocBuilder<SignUpCubit, SignUpState>(
                  builder: (context, state) {
                    if (state is SignUpLoading) {
                      return const CircularProgressIndicator(
                        color: Color(0xFFD99022),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: CustomButton(
                          text: 'Sign Up',
                          textColor: Colors.white,
                          bgColor: const Color(0xFFD99022),
                          onTap: () {
                            final isValid = _formKey.currentState?.validate();
                            final username = _usernameController.text.trim();
                            final email = _emailController.text.trim();
                            final password = _passwordController.text.trim();
                            final rePassword =
                                _rePasswordController.text.trim();
                            if (isValid == true) {
                              context.read<SignUpCubit>().signUp(
                                    username,
                                    email,
                                    password,
                                    rePassword,
                                  );
                            }
                          },
                        ),
                      );
                    }
                  },
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

                // Sign In Text
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
                    Navigator.pushReplacementNamed(context, '/signIn');
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
        ),
      ),
    );
  }
}
