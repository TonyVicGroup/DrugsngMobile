enum Environment { dev, prod }

abstract class AppEnvironment {
  static late String baseApiUrl;

  static late Environment _environment;
  static Environment get value => _environment;

  static bool get isDev => _environment == Environment.dev;

  static setupEnv(Environment env) {
    _environment = env;
    switch (env) {
      case Environment.dev:
        baseApiUrl = '';
        break;
      case Environment.prod:
        baseApiUrl = '';
        break;
    }
  }
}
