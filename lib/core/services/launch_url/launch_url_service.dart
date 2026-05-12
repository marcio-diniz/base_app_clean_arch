import 'package:url_launcher/url_launcher.dart' as url_launch_package;

import 'i_launch_url_service.dart';
import 'launch_url_type.dart';

class LaunchUrlService implements ILaunchUrlService {
  @override
  Future<void> launchUrl({
    required String url,
    LaunchUrlType launchUrlType = LaunchUrlType.platformDefault,
  }) async {
    final uri = Uri.parse(url);
    late url_launch_package.LaunchMode launchMode;

    switch (launchUrlType) {
      case LaunchUrlType.platformDefault:
        launchMode = url_launch_package.LaunchMode.platformDefault;
        break;
      case LaunchUrlType.browser:
        launchMode = url_launch_package.LaunchMode.inAppBrowserView;
        break;
      case LaunchUrlType.externalApp:
        launchMode = url_launch_package.LaunchMode.externalApplication;
        break;
    }

    await url_launch_package.launchUrl(
      uri,
      mode: launchMode,
    );
  }

  @override
  Future<bool> canLaunchUrl(Uri url) async {
    return await url_launch_package.canLaunchUrl(url);
  }

  @override
  Future<void> launchPhoneDialer({required String? phoneNumber}) async {
    if (phoneNumber == null || phoneNumber == '') return;

    final uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      url_launch_package.launchUrl(uri);
    }
  }
}
