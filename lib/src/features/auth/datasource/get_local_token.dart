import 'package:hive_flutter/hive_flutter.dart';

class TokenPreference {
  static const boxName = "LOGIN_TOKEN_BOX";

  static late Box<String> box;

  static Future init() async {
    box = await Hive.openBox<String>(boxName);
  }

  static bool hasToken() => (getToken() ?? '').isNotEmpty;

  static String? getToken() => box.get(boxName);

  static void updateToken({required String token}) => box.put(boxName, token);

  static Future reset() => box.clear();
}
