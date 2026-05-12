enum PushPriorityEnum {
  low('LOW'),
  high('HIGH'),
  undefined('');

  final String value;
  const PushPriorityEnum(this.value);

  static PushPriorityEnum fromValue(String? value) {
    return PushPriorityEnum.values.firstWhere(
      (e) => e.value == value,
      orElse: () => undefined,
    );
  }
}
