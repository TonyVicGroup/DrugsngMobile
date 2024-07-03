import 'package:drugs_ng/src/features/auth/data/models/auth_user_profile.dart';
import 'package:drugs_ng/src/features/auth/data/models/signup_data.dart';
import 'package:drugs_ng/src/features/auth/domain/repositories/auth_datasource.dart';

class AuthDatasourceImpl extends AuthDatasource {
  @override
  Future attemptLogin({required String token}) async {
    Future.delayed(const Duration(seconds: 2));
  }

  @override
  Future login({required String email, required String password}) async {
    Future.delayed(const Duration(seconds: 2));
  }

  @override
  Future setupProfile({required AuthUserProfile authProfile}) async {
    Future.delayed(const Duration(seconds: 2));
  }

  @override
  Future signup({required SignupData data}) async {
    Future.delayed(const Duration(seconds: 2));
  }
}
