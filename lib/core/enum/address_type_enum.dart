import 'package:drugs_ng/core/contants/app_image.dart';

enum AddressTypeEnum {
  home,
  work,
  other;

  static List<AddressTypeEnum> get all => [home, work, other];

  bool get isHome => this == home;
  bool get isWork => this == work;
  bool get isOther => this == other;

  String get displayName {
    switch (this) {
      case home:
        return "Home";
      case work:
        return "Work";
      case other:
        return "Others";
    }
  }

  String get icon {
    switch (this) {
      case home:
        return AppSvg.house;
      case work:
        return AppSvg.work;
      case other:
        return AppSvg.work;
    }
  }
}
