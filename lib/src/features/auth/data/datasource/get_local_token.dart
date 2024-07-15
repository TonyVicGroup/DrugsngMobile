import 'package:drugs_ng/src/features/auth/domain/models/user.dart';
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

  static User? getUser() {
    final data = Map<String, dynamic>.from(box.get(_user) ?? {});
    return data.isEmpty ? null : User.fromMap(data);
  }

  static void updateUser(User data) => box.put(_user, data.toMap());

  static Future reset() => box.clear();
}
