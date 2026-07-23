import 'package:drugs_ng/core/enum/gender_enum.dart';
import 'package:equatable/equatable.dart';

class UserProfileModel extends Equatable {
  const UserProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    this.gender,
    required this.dob,
    required this.isDeleted,
    required this.accountStatus,
    required this.verified,
    required this.roles,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] as int,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String? ?? "",
      gender:
          json['gender'] != null
              ? GenderEnum.fromString(json['gender'] as String)
              : null,
      dob: DateTime.parse(json['dob'] as String),
      isDeleted: json['isDeleted'] as bool,
      accountStatus: json['accountStatus'] as String,
      verified: json['verified'] as bool,
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
    );
  }

  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final GenderEnum? gender;
  final DateTime dob;
  final bool isDeleted;
  final String accountStatus;
  final bool verified;
  final List<String> roles;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender?.id,
      'dob': dob.toIso8601String(),
      'isDeleted': isDeleted,
      'accountStatus': accountStatus,
      'verified': verified,
      'roles': roles,
    };
  }

  String get avatar {
    return '${firstName[0]}${lastName[0]}'.toUpperCase();
  }

  String get fullName {
    return '$firstName $lastName';
  }

  @override
  List<Object?> get props => [
    id,
    firstName,
    lastName,
    email,
    phoneNumber,
    gender,
    dob,
    isDeleted,
    accountStatus,
    verified,
    roles,
  ];

  // UserProfileModel copyWith({
  //   int? id,
  //   String? firstName,
  //   String? lastName,
  //   String? email,
  //   String? phoneNumber,
  //   GenderEnum? gender,
  //   DateTime? dob,
  //   bool? isDeleted,
  //   String? accountStatus,
  //   bool? verified,
  //   List<String>? roles,
  // }) {
  //   return UserProfileModel(
  //     id: id ?? this.id,
  //     firstName: firstName ?? this.firstName,
  //     lastName: lastName ?? this.lastName,
  //     email: email ?? this.email,
  //     phoneNumber: phoneNumber ?? this.phoneNumber,
  //     gender: gender ?? this.gender,
  //     dob: dob ?? this.dob,
  //     isDeleted: isDeleted ?? this.isDeleted,
  //     accountStatus: accountStatus ?? this.accountStatus,
  //     verified: verified ?? this.verified,
  //     roles: roles ?? this.roles,
  //   );
  // }
}
