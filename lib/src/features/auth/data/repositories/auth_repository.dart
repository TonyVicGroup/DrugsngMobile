import 'package:drugs_ng/src/core/data/models/app_error.dart';
import 'package:drugs_ng/src/core/utils/app_data_types.dart';
import 'package:drugs_ng/src/features/auth/data/models/auth_user_profile.dart';
import 'package:drugs_ng/src/features/auth/data/models/signup_data.dart';
import 'package:drugs_ng/src/features/auth/domain/repositories/auth_datasource.dart';
import 'package:either_dart/either.dart';

class AuthRepository {
  final AuthDatasource datasource;

  AuthRepository(this.datasource);

  AsyncErrorOr attemptLogin({required String token}) async {
    try {
      await datasource.attemptLogin(token: token);
      return const Right(null);
    } catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  AsyncErrorOr login({required String email, required String password}) async {
    try {
      await datasource.login(email: email, password: password);
      return const Right(null);
    } catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  AsyncErrorOr setupProfile({required AuthUserProfile authProfile}) async {
    try {
      await datasource.setupProfile(authProfile: authProfile);
      return const Right(null);
    } catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  AsyncErrorOr signup({required SignupData data}) async {
    try {
      await datasource.signup(data: data);
      return const Right(null);
    } catch (e) {
      return Left(AppError(e.toString()));
    }
  }
}
