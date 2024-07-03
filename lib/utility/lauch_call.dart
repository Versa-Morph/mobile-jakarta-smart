import 'package:smart_jakarta/exception/auth_exception.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchCall {
  void makeCall(String phoneNum) async {
    final Uri url = Uri(
      scheme: 'tel',
      path: phoneNum,
    );
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      }
    } catch (e) {
      throw const AuthException('Somethings wrong, couldn\'t make a call');
    }
  }
}
