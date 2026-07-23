import 'package:equatable/equatable.dart';

class BenefitData extends Equatable {
  static const String _idkey = "id";
  static const String _benefitkey = "benefit";

  final int id;
  final String benefit;

  const BenefitData({
    required this.id,
    required this.benefit,
  });

  factory BenefitData.fromJson(Map json) => BenefitData(
        id: json[_idkey],
        benefit: json[_benefitkey],
      );

  @override
  List<Object?> get props => [id, benefit];
}
