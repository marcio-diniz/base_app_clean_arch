import 'launch_url_type.dart';

abstract class ILaunchUrlService {
  Future<void> launchUrl({
    required String url,
    LaunchUrlType launchUrlType = LaunchUrlType.platformDefault,
  });

  Future<bool> canLaunchUrl(Uri url);

  Future<void> launchPhoneDialer({required String? phoneNumber});
}
