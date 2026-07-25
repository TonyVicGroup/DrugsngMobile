enum AccountTypeEnum {
  patient,
  doctor,
  delivery;

  bool get isPatient => this == patient;
  bool get isDoctor => this == doctor;
  bool get isDelivery => this == delivery;

  String get id => switch (this) {
    AccountTypeEnum.patient => 'patient',
    AccountTypeEnum.doctor => 'doctor',
    AccountTypeEnum.delivery => 'delivery',
  };

  static AccountTypeEnum fromString(String? value) => switch (value
      ?.toLowerCase()) {
    'patient' => AccountTypeEnum.patient,
    'doctor' => AccountTypeEnum.doctor,
    'delivery' => AccountTypeEnum.delivery,
    _ => AccountTypeEnum.patient,
  };
}
