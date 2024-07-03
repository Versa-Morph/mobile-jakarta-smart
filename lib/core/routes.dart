import 'package:flutter/material.dart';
import 'package:smart_jakarta/views/home/home_page.dart';
import 'package:smart_jakarta/views/login/sign_in/sign_in_page.dart';
import 'package:smart_jakarta/views/login/sign_up_page.dart';
import 'package:smart_jakarta/views/login/term_of_use.dart';
import 'package:smart_jakarta/views/missing/missing_page.dart';
import 'package:smart_jakarta/views/root_page.dart';
import 'package:smart_jakarta/views/welcome/welcome_page.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const RootPage(),
        );
      case '/welcome':
        return MaterialPageRoute(
          builder: (context) => const WelcomePage(),
        );
      case '/signIn':
        return MaterialPageRoute(
          builder: (context) => const SignInPageProvider(),
        );
      case '/signUp':
        return MaterialPageRoute(
          builder: (context) => const SignUpPage(),
        );
      case '/termOfUse':
        return MaterialPageRoute(
          builder: (context) => const TermOfUsePage(),
        );
      case '/home':
        return MaterialPageRoute(
          builder: (context) => const HomePageWrapper(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const MissingPage(),
        );
    }
  }
}
