enum GenderEnum {
  male,
  female;

  static List<GenderEnum> get all => [male, female];

  String get id => switch (this) {
    male => "m",
    female => "f",
  };

  String get nameCapitalized => switch (this) {
    male => "Male",
    female => "Female",
  };

  static GenderEnum fromString(String value) => switch (value.toLowerCase()) {
    'm' => male,
    'male' => male,
    'f' => female,
    'female' => female,
    _ => male,
  };

  @override
  String toString() {
    return nameCapitalized;
  }
}
