import 'package:equatable/equatable.dart';
import 'package:phonecodes/phonecodes.dart';

class CountryCode extends Equatable {
  final String imageUrl;
  final String code;

  const CountryCode(this.imageUrl, this.code);

  static List<CountryCode> get all {
    // return [
    //   CountryCode(Country.nigeria.flag, Country.nigeria.dialCode),
    // ];
    // Countries.list[0] = ;
    // Countries.list.removeWhere((e) => e.dialCode == '+234');
    final data = [
      Countries.list.firstWhere((e) => e.dialCode == '+234'),
      ...Countries.list.where((e) => e.dialCode != '+234'),
    ];
    return data.map((e) {
      return CountryCode(e.flag, e.dialCode);
    }).toList();
  }

  @override
  List<Object?> get props => [imageUrl, code];

  @override
  String toString() {
    return '$imageUrl $code';
  }
}
