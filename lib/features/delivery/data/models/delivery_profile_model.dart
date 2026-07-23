import 'package:equatable/equatable.dart';

class DeliveryProfileModel extends Equatable {
  const DeliveryProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.dateOfBirth,
    required this.profileImage,
    required this.location,
    required this.yearsOfExp,
    required this.ninDocumentUrl,
    required this.licenseDocumentUrl,
    required this.isAvailable,
    required this.isActive,
    required this.isProfileApproved,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final DateTime dateOfBirth;
  final String profileImage;
  final String location;
  final int yearsOfExp;
  final String ninDocumentUrl;
  final String licenseDocumentUrl;
  final bool isAvailable;
  final bool isActive;
  final bool isProfileApproved;

  @override
  List<Object?> get props => [
    id,
    firstName,
    lastName,
    email,
    phone,
    dateOfBirth,
    profileImage,
    location,
    yearsOfExp,
    ninDocumentUrl,
    licenseDocumentUrl,
    isAvailable,
    isActive,
    isProfileApproved,
  ];
}
