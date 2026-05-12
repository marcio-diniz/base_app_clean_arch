enum NavigationTypeEnum {
  push('push'),
  replacement('replacement'),
  pop('pop'),
  changedTab('changed_tab');

  final String value;
  const NavigationTypeEnum(this.value);

  static NavigationTypeEnum fromValue(String value) {
    return NavigationTypeEnum.values.firstWhere((e) => e.value == value,
        orElse: () => throw ArgumentError('Invalid enum value'));
  }
}
