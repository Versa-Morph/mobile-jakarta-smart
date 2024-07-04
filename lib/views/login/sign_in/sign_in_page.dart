import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_jakarta/views/login/sign_in/cubit/sign_in_cubit.dart';
import 'package:smart_jakarta/views/login/widgets/content_header.dart';
import 'package:smart_jakarta/views/login/widgets/custom_button.dart';
import 'package:smart_jakarta/views/login/widgets/custom_divider.dart';
import 'package:smart_jakarta/views/login/widgets/custom_textfield.dart';
import 'package:smart_jakarta/views/login/widgets/social_button.dart';

class SignInPageProvider extends StatelessWidget {
  const SignInPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(),
      child: const SignInPage(),
    );
  }
}

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SignInCubit, SignInState>(
        listener: (context, state) {
          if (state is SignInSucces) {
            // TODO: CHANGE TO PUSHREMOVE
            Navigator.pushNamed(
              context,
              '/home',
            );
          } else if (state is SignInError) {
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
                CustomTextfield(
                  hintText: 'Username/Email',
                  prefixImgPath: 'assets/icons/email_icon.png',
                  textController: _emailController,
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

                CustomTextfield(
                  hintText: 'Password',
                  prefixImgPath: 'assets/icons/pass_icon.png',
                  textController: _passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter The Password';
                    }
                    return null;
                  },
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
                BlocBuilder<SignInCubit, SignInState>(
                  builder: (context, state) {
                    if (state is SignInLoading) {
                      return const CircularProgressIndicator(
                        color: Color(0xFFD99022),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: CustomButton(
                          text: 'Sign In',
                          textColor: Colors.white,
                          bgColor: const Color(0xFFD99022),
                          onTap: () {
                            final isValid = _formKey.currentState?.validate();
                            final email = _emailController.text.trim();
                            final password = _passwordController.text.trim();
                            if (isValid == true) {
                              context
                                  .read<SignInCubit>()
                                  .signIn(email, password);
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
        ),
      ),
    );
  }
}
