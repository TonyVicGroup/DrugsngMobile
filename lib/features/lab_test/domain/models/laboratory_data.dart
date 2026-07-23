import 'package:equatable/equatable.dart';

class LaboratoryData extends Equatable {
  static const String _idKey = "id";
  static const String _nameKey = "name";
  static const String _phoneNumberKey = "phoneNumber";
  static const String _addressKey = "address";

  final int id;
  final String name;
  final String phoneNumber;
  final String address;

  const LaboratoryData({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.address,
  });

  factory LaboratoryData.fromJson(Map json) => LaboratoryData(
        id: json[_idKey],
        name: json[_nameKey],
        phoneNumber: json[_phoneNumberKey],
        address: json[_addressKey],
      );

  @override
  List<Object?> get props => [];
}
