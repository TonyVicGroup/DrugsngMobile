import 'package:drugs_ng/features/auth/domain/models/account_data.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserPreference {
  static const boxName = "LOGIN_TOKEN_BOX";
  static const _user = "USER";

  static late Box<dynamic> box;

  static Future init() async {
    box = await Hive.openBox<dynamic>(boxName);
  }

  // change to getAccount
  static AccountData getUser() {
    final data = Map<String, dynamic>.from(box.get(_user) ?? {});
    return data.isEmpty ? AccountData() : AccountData.fromJson(data);
  }

  // change to updateAccount
  static void updateUser(AccountData data) => box.put(_user, data.toJson());

  static Future reset() => box.clear();
}
