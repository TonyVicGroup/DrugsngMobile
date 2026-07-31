import 'package:drugs_ng/core/enum/address_type_enum.dart';

class UserAddress {
  static const String _idKey = "id";
  static const String _countryIdKey = "countryId";
  static const String _stateIdKey = "stateId";
  static const String _localGovernmentIdKey = "localGovernmentId";
  static const String _addressKey = "address";
  static const String _zipCodeKey = "zipCode";
  static const String _labelKey = "label";

  final int id;
  final int countryId;
  final int stateId;
  final int localGovernmentId;
  final String address;
  final String zipCode;
  final String label;
  final String? state;
  final String? city;

  UserAddress({
    required this.id,
    required this.stateId,
    required this.countryId,
    required this.localGovernmentId,
    required this.address,
    required this.zipCode,
    required this.label,
    this.state,
    this.city,
  });

  factory UserAddress.fromJson(Map<String, dynamic> json) {
    return UserAddress(
      id: json[_idKey],
      countryId: int.parse(json[_countryIdKey].toString()),
      stateId: int.parse(json[_stateIdKey].toString()),
      localGovernmentId: int.parse(
        (json[_localGovernmentIdKey] ?? json['cityId']).toString(),
      ),
      address: json[_addressKey] ?? '',
      zipCode: json[_zipCodeKey] ?? '',
      label: json[_labelKey] ?? '',
      state: json['state'],
      city: json['city'],
    );
  }

  Map<String, dynamic> toJson() => {
    _stateIdKey: stateId,
    _localGovernmentIdKey: localGovernmentId,
    _countryIdKey: countryId,
    _addressKey: address,
    _zipCodeKey: zipCode,
    _labelKey: label,
  };

  AddressTypeEnum get addressType => switch (label) {
    'home' => AddressTypeEnum.home,
    'work' => AddressTypeEnum.work,
    'other' => AddressTypeEnum.other,
    'others' => AddressTypeEnum.other,
    _ => AddressTypeEnum.home,
  };

  /// create list of sample addresses
  static List<UserAddress> sampleAddresses = [
    UserAddress(
      id: 1,
      stateId: 1,
      countryId: 1,
      localGovernmentId: 1,
      address: 'address',
      zipCode: 'zipCode',
      label: 'label',
    ),
    UserAddress(
      id: 1,
      stateId: 1,
      countryId: 1,
      localGovernmentId: 1,
      address: 'address',
      zipCode: 'zipCode',
      label: 'label',
    ),
    UserAddress(
      id: 1,
      stateId: 1,
      countryId: 1,
      localGovernmentId: 1,
      address: 'address',
      zipCode: 'zipCode',
      label: 'label',
    ),
    UserAddress(
      id: 1,
      stateId: 1,
      countryId: 1,
      localGovernmentId: 1,
      address: 'address',
      zipCode: 'zipCode',
      label: 'label',
    ),
    UserAddress(
      id: 1,
      stateId: 1,
      countryId: 1,
      localGovernmentId: 1,
      address: 'address',
      zipCode: 'zipCode',
      label: 'label',
    ),
    UserAddress(
      id: 1,
      stateId: 1,
      countryId: 1,
      localGovernmentId: 1,
      address: 'address',
      zipCode: 'zipCode',
      label: 'label',
    ),
  ];
}
