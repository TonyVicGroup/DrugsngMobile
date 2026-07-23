import 'package:equatable/equatable.dart';

class LabProfileModel extends Equatable {
  final int id;
  final String name;
  final String phoneNumber;
  final String address;
  final String imageUrl;
  final List<TestModel> tests;

  const LabProfileModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.imageUrl,
    required this.tests,
  });

  factory LabProfileModel.fromJson(Map<String, dynamic> json) {
    return LabProfileModel(
      id: json['id'] as int,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      address: json['address'] as String,
      imageUrl: json['imageUrl'] as String,
      tests:
          (json['tests'] as List<dynamic>)
              .map((e) => TestModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  @override
  List<Object?> get props => [id, name, phoneNumber, address, imageUrl, tests];
}

class TestModel extends Equatable {
  final int id;
  final String name;
  final String description;
  final String imageUrl;

  const TestModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  @override
  List<Object?> get props => [id, name, description, imageUrl];
}
