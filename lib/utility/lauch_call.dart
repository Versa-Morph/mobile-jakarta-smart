import 'package:url_launcher/url_launcher.dart';

class LaunchCall {
  Future<void> makeCall(String phoneNum) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNum);

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print('cannot make a call');
    }
  }
}
