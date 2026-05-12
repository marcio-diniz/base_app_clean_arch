enum NotificationConfigTypeEnum {
  undefined(''),
  emergencyPhoneCall('EMERGENCY_PHONE_CALLS'),
  authorizedDriver('AUTHORIZED_DRIVER'),
  guardianModeActivated('GUARDIAN_MODE_ACTIVATED');

  final String value;
  const NotificationConfigTypeEnum(this.value);

  static NotificationConfigTypeEnum fromValue(String? value) {
    return NotificationConfigTypeEnum.values.firstWhere((e) => e.value == value,
        orElse: () => NotificationConfigTypeEnum.undefined);
  }
}
