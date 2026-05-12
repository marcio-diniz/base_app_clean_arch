enum PushNotificationTypeEnum {
  newDriver('NEW_DRIVER'),
  snapshotImage('INTERNAL_SNAPSHOT'),
  panicButton('PANIC_BUTTON'),
  blockStatus('BLOCK_STATUS'),
  blockVehicleRequest('BLOCK_VEHICLE_REQUEST'),
  fileUploaded('FILE_UPLOADED'),
  ignitionInGuardianMode('GUARDIAN_MODE_IGNITION'),
  route('ROUTE'),
  undefined('DEFAULT');

  final String value;
  const PushNotificationTypeEnum(this.value);

  static PushNotificationTypeEnum fromValue(String? value) {
    return PushNotificationTypeEnum.values.firstWhere(
        (e) => e.value == (value ?? 'DEFAULT').toUpperCase(),
        orElse: () => PushNotificationTypeEnum.undefined);
  }
}
