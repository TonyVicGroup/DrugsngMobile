import 'package:drugs_ng/features/auth/domain/models/account_model.dart';

class AccountData {
  final bool firstTimeUser;
  final String? email;
  final String? password;
  final bool setBiometric;
  final AccountModel? accountModel;

  AccountData({
    this.firstTimeUser = true,
    this.setBiometric = false,
    this.email,
    this.password,
    this.accountModel,
  });

  AccountData copyWith({
    bool? firstTimeUser,
    bool? setBiometric,
    String? email,
    String? password,
    AccountModel? accountModel,
  }) {
    return AccountData(
      firstTimeUser: firstTimeUser ?? this.firstTimeUser,
      setBiometric: setBiometric ?? this.setBiometric,
      email: email ?? this.email,
      password: password ?? this.password,
      accountModel: accountModel ?? this.accountModel,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstTimeUser': firstTimeUser,
      'setBiometric': setBiometric,
      'email': email,
      'password': password,
      'accountModel': accountModel?.toJson(),
    };
  }

  factory AccountData.fromJson(Map<String, dynamic> json) {
    return AccountData(
      firstTimeUser: json['firstTimeUser'] as bool? ?? true,
      setBiometric: json['setBiometric'] as bool? ?? false,
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
