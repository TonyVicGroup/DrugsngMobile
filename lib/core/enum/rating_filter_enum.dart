enum RatingFilterEnum {
  all,
  one,
  two,
  three,
  four,
  five;

  int get valueInt => switch (this) {
    one => 1,
    two => 2,
    three => 3,
    four => 4,
    five => 5,
    all => 0,
  };

  String get label => switch (this) {
    one => 'One',
    two => 'Two',
    three => 'Three',
    four => 'Four',
    five => 'Five',
    all => 'All',
  };

  static List<RatingFilterEnum> get allValues => [
    all,
    one,
    two,
    three,
    four,
    five,
  ];
}
