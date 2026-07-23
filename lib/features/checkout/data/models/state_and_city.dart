import 'package:equatable/equatable.dart';

class StateModel extends Equatable {
  final String name;
  final int id;
  final int countryId;

  const StateModel({
    required this.name,
    required this.id,
    required this.countryId,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
      name: json['name'],
      id: json['id'],
      countryId: json['countryId'],
    );
  }

  String get stateKey => '$countryId-$id';

  @override
  List<Object?> get props => [name, id, countryId];

  @override
  String toString() {
    return name;
  }
}

class CountryModel extends Equatable {
  final String name;
  final int id;

  const CountryModel({
    required this.name,
    required this.id,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      name: json['name'],
      id: json['id'],
    );
  }

  @override
  List<Object?> get props => [name, id];

  @override
  String toString() {
    return name;
  }
}

class CityModel extends Equatable {
  final String name;
  final int id;
  final int countryId;

  const CityModel({
    required this.name,
    required this.id,
    required this.countryId,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      name: json['name'],
      id: json['id'],
      countryId: json['stateId'],
    );
  }

  @override
  List<Object?> get props => [name, id, countryId];

  @override
  String toString() {
    return name;
  }
}
