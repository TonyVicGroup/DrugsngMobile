import 'package:equatable/equatable.dart';

class CreateDoctorResponse extends Equatable {
  final int id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? profileImage;
  final String? ninDocumentUrl;
  final String? licenseDocumentUrl;

  const CreateDoctorResponse({
    required this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.profileImage,
    this.ninDocumentUrl,
    this.licenseDocumentUrl,
  });

  factory CreateDoctorResponse.fromJson(Map<String, dynamic> json) {
    return CreateDoctorResponse(
      id: (json['id'] as num? ?? 0).toInt(),
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      profileImage: json['profileImage'] as String?,
      ninDocumentUrl: json['ninDocumentUrl'] as String?,
      licenseDocumentUrl: json['licenseDocumentUrl'] as String?,
    );
  }

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        phone,
        profileImage,
        ninDocumentUrl,
        licenseDocumentUrl,
      ];
}
