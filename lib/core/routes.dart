import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_jakarta/views/home/home_page.dart';
import 'package:smart_jakarta/views/home/profile/add_profile/add_profile_page.dart';
import 'package:smart_jakarta/views/incident/report_incident_page.dart';
import 'package:smart_jakarta/views/login/sign_in/sign_in_page.dart';
import 'package:smart_jakarta/views/login/sign_up/sign_up_page.dart';
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
          builder: (context) => const SignUpPageProvider(),
        );
      case '/termOfUse':
        return MaterialPageRoute(
          builder: (context) => const TermOfUsePage(),
        );
      case '/home':
        return MaterialPageRoute(
          builder: (context) => const HomePageProvider(),
        );
      case '/add_profile':
        return MaterialPageRoute(
          builder: (context) => const AddProfilePageProvider(),
        );
      case '/report':
        final args = settings.arguments as Marker;
        return MaterialPageRoute(
          builder: (context) => ReportIncidentPageProvider(marker: args),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const MissingPage(),
        );
    }
  }
}
