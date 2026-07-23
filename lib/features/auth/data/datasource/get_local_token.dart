import 'package:drugs_ng/features/auth/domain/models/account_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserPreference {
  static const boxName = "LOGIN_TOKEN_BOX";
  static const _token = "TOKEN";
  static const _user = "USER";

  static late Box<dynamic> box;

  static Future init() async {
    box = await Hive.openBox<dynamic>(boxName);
  }

  static String? getToken() => box.get(_token);

  static void updateToken(String token) => box.put(_token, token);

  // change to getAccount
  static AccountModel? getUser() {
    final data = Map<String, dynamic>.from(box.get(_user) ?? {});
    return data.isEmpty ? null : AccountModel.fromJson(data);
  }

  // change to updateAccount
  static void updateUser(AccountModel data) => box.put(_user, data.toJson());

  static Future reset() => box.clear();
}
