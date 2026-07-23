import 'package:equatable/equatable.dart';

class SampleData extends Equatable {
  static const String _idkey = "id";
  static const String _samplekey = "sample";

  final int id;
  final String sample;

  const SampleData({
    required this.id,
    required this.sample,
  });

  factory SampleData.fromJson(Map json) => SampleData(
        id: json[_idkey],
        sample: json[_samplekey],
      );

  @override
  List<Object?> get props => [id, sample];
}
