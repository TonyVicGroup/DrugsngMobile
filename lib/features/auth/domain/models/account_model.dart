import 'package:drugs_ng/core/enum/account_type_enum.dart';

class AccountModel {
  final int userId;
  final String email;
  final String jwtToken;
  final String fullName;
  final DateTime jwtTokenExpiry;
  final String refreshToken;
  final DateTime refreshExpiry;
  final String accountStatus;
  final AccountTypeEnum accountType;
  final bool isEmailConfirmed;
  final bool isPhoneConfirmed;
  final List<String> permissions;

  AccountModel({
    required this.userId,
    required this.email,
    required this.jwtToken,
    required this.fullName,
    required this.jwtTokenExpiry,
    required this.refreshToken,
    required this.refreshExpiry,
    required this.accountStatus,
    required this.accountType,
    required this.isEmailConfirmed,
    required this.isPhoneConfirmed,
    required this.permissions,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      userId: json['userId'] as int,
      email: json['email'] as String,
      jwtToken: json['jwtToken'] as String,
      fullName: json['fullName'] as String,
      jwtTokenExpiry: DateTime.parse(json['jwtTokenExpiry'] as String),
      refreshToken: json['refreshToken'] as String,
      refreshExpiry: DateTime.parse(json['refreshExpiry'] as String),
      accountStatus: json['accountStatus'] as String,
      accountType: AccountTypeEnum.fromString(json['accountType'] as String),
      isEmailConfirmed: json['isEmailConfirmed'] as bool,
      isPhoneConfirmed: json['isPhoneConfirmed'] as bool,
      permissions:
          (json['permissions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'jwtToken': jwtToken,
      'fullName': fullName,
      'jwtTokenExpiry': jwtTokenExpiry.toIso8601String(),
      'refreshToken': refreshToken,
      'refreshExpiry': refreshExpiry.toIso8601String(),
      'accountStatus': accountStatus,
      'accountType': accountType.id,
      'isEmailConfirmed': isEmailConfirmed,
      'isPhoneConfirmed': isPhoneConfirmed,
      'permissions': permissions,
    };
  }

  AccountModel copyWith({
    int? userId,
    String? email,
    String? jwtToken,
    String? fullName,
    DateTime? jwtTokenExpiry,
    String? refreshToken,
    DateTime? refreshExpiry,
    String? accountStatus,
    AccountTypeEnum? accountType,
    bool? isEmailConfirmed,
    bool? isPhoneConfirmed,
    List<String>? permissions,
  }) {
    return AccountModel(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      jwtToken: jwtToken ?? this.jwtToken,
      fullName: fullName ?? this.fullName,
      jwtTokenExpiry: jwtTokenExpiry ?? this.jwtTokenExpiry,
      refreshToken: refreshToken ?? this.refreshToken,
      refreshExpiry: refreshExpiry ?? this.refreshExpiry,
      accountStatus: accountStatus ?? this.accountStatus,
      accountType: accountType ?? this.accountType,
      isEmailConfirmed: isEmailConfirmed ?? this.isEmailConfirmed,
      isPhoneConfirmed: isPhoneConfirmed ?? this.isPhoneConfirmed,
      permissions: permissions ?? this.permissions,
    );
  }
}
