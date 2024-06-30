abstract class AuthDatasource {
  Future<String> login(String email, String password);
  Future<String> signup(String email, String password, bool getUpdates);
  Future<String> sendEmailVerification(String email);
  Future<String> sendPhoneVerification(String phone);
  Future<String> setupProfile(
      String firstName, String lastName, DateTime birthday, bool gender);
}
