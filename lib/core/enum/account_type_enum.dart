enum AccountTypeEnum {
  user,
  doctor,
  // lab,
  delivery;

  bool get isUser => this == user;
  bool get isDoctor => this == doctor;
  // bool get isLab => this == lab;
  bool get isDelivery => this == delivery;

  String get id => switch (this) {
    AccountTypeEnum.user => 'user',
    AccountTypeEnum.doctor => 'doctor',
    // AccountTypeEnum.lab => 'lab',
    AccountTypeEnum.delivery => 'delivery',
  };

  static AccountTypeEnum fromString(String? value) => switch (value
      ?.toLowerCase()) {
    'user' => AccountTypeEnum.user,
    'doctor' => AccountTypeEnum.doctor,
    // 'lab' => AccountTypeEnum.lab,
    'delivery' => AccountTypeEnum.delivery,
    _ => AccountTypeEnum.user,
  };
}
