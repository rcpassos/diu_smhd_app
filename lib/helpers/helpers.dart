import 'package:url_launcher/url_launcher.dart';

Future<void> openUrl(String url) async {
  Uri _uri = Uri.parse(url);

  if (await canLaunchUrl(_uri)) {
    await launchUrl(_uri);
  } else {
    throw 'Could not launch $url';
  }
}
