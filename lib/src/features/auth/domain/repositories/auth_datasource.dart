import 'package:drugs_ng/src/features/auth/data/models/auth_user_profile.dart';
import 'package:drugs_ng/src/features/auth/data/models/signup_data.dart';

abstract class AuthDatasource {
  Future attemptLogin({required String token});
  Future login({required String email, required String password});
  Future signup({required SignupData data});
  Future setupProfile({required AuthUserProfile authProfile});
}
