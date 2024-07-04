import 'package:smart_jakarta/exception/exception.dart';
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
      throw BaseException('Somethings wrong, couldn\'t make a call');
    }
  }
}
