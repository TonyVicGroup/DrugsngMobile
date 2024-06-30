import 'package:hive_flutter/hive_flutter.dart';

class TokenPreference {
  static const boxName = "LOGIN_TOKEN_BOX";

  static late Box<String> box;

  static Future init() async {
    box = await Hive.openBox<String>(boxName);
  }

  static bool hasToken() {
    String token = getToken() ?? '';
    return token.isNotEmpty;
  }

  static String? getToken() {
    String? token = box.get(boxName);
    return token;
  }

  static void updateToken({required String token}) {
    box.put(boxName, token);
  }

  static Future reset() async {
    await box.clear();
  }
}
