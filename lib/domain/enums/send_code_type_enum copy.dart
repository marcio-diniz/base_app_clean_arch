enum SendCodeTypeEnum {
  sms('SMS'),
  phoneCall('PHONE_CALL'),
  undefined('');

  final String value;
  const SendCodeTypeEnum(this.value);

  static SendCodeTypeEnum fromValue(String value) {
    return SendCodeTypeEnum.values.firstWhere((e) => e.value == value,
        orElse: () => SendCodeTypeEnum.undefined);
  }
}
