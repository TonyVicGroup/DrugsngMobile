import 'package:drugs_ng/core/enum/account_type_enum.dart';
import 'package:drugs_ng/features/auth/domain/models/account_model.dart';

class AccountData {
  final bool firstTimeUser;
  final String? email;
  final String? password;
  final bool setBiometric;
  final AccountModel? accountModel;
  final AccountTypeEnum accountType;

  AccountData({
    this.firstTimeUser = true,
    this.setBiometric = false,
    this.accountType = AccountTypeEnum.patient,
    this.email,
    this.password,
    this.accountModel,
  });

  AccountData copyWith({
    bool? firstTimeUser,
    bool? setBiometric,
    AccountTypeEnum? accountType,
    String? email,
    String? password,
    AccountModel? accountModel,
  }) {
    return AccountData(
      firstTimeUser: firstTimeUser ?? this.firstTimeUser,
      setBiometric: setBiometric ?? this.setBiometric,
      accountType: accountType ?? this.accountType,
      email: email ?? this.email,
      password: password ?? this.password,
      accountModel: accountModel ?? this.accountModel,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstTimeUser': firstTimeUser,
      'setBiometric': setBiometric,
      'accountType': accountType.id,
      'email': email,
      'password': password,
      'accountModel': accountModel?.toJson(),
    };
  }

  factory AccountData.fromJson(Map<String, dynamic> json) {
    return AccountData(
      firstTimeUser: json['firstTimeUser'] as bool? ?? true,
      setBiometric: json['setBiometric'] as bool? ?? false,
      accountType: AccountTypeEnum.fromString(json['accountType'] as String?),
      email: json['email'] as String?,
      password: json['password'] as String?,
      accountModel:
          json['accountModel'] != null
              ? AccountModel.fromJson(
                json['accountModel'] as Map<String, dynamic>,
              )
              : null,
    );
  }
}
