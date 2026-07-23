import 'package:equatable/equatable.dart';

class PurposeData extends Equatable {
  static const String _idkey = "id";
  static const String _purposekey = "purpose";

  final int id;
  final String purpose;

  const PurposeData({
    required this.id,
    required this.purpose,
  });

  factory PurposeData.fromJson(Map json) => PurposeData(
        id: json[_idkey],
        purpose: json[_purposekey],
      );

  @override
  List<Object?> get props => [id, purpose];
}
