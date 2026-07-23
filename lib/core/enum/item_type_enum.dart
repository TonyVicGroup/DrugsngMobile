enum ItemTypeEnum {
  product,
  test,
  package;

  bool get isProduct => this == ItemTypeEnum.product;
  bool get isTest => this == ItemTypeEnum.test;
  bool get isPackage => this == ItemTypeEnum.package;

  String get id => switch (this) {
    product => 'product',
    test => 'test',
    package => 'package',
  };

  static ItemTypeEnum fromString(String value) => switch (value.toLowerCase()) {
    'product' => product,
    'test' => test,
    'package' => package,
    _ => product,
  };
}
