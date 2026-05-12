class PhoneUtils {
  static String formatPhoneNumber({
    required String countryCode,
    required String phone,
  }) {
    return countryCode + cleanPhoneNumber(phone: phone);
  }

  static String cleanPhoneNumber({
    required String phone,
  }) {
    return phone.replaceAll('(', '').replaceAll(')', '').replaceAll('-', '');
  }
}
