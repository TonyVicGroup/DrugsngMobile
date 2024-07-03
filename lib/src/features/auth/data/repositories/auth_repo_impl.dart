import 'package:drugs_ng/src/core/data/models/app_responses.dart';
import 'package:drugs_ng/src/core/utils/app_data_types.dart';
import 'package:drugs_ng/src/core/utils/rest_service.dart';
import 'package:drugs_ng/src/features/auth/domain/models/auth_models.dart';
import 'package:drugs_ng/src/features/auth/domain/models/user.dart';
import 'package:drugs_ng/src/features/auth/domain/repositories/auth_repo.dart';
import 'package:either_dart/either.dart';

class AuthRepositoryImpl extends AuthRepository {
  final RestService service;

  AuthRepositoryImpl(this.service);

  @override
  AsyncApiErrorOr<void> confirmAccount(String otp) async {
    try {
      final response = await service.post(
        url: 'auth/account-confirmation',
        data: {"token": otp},
      );

      if (response.hasError) return Left(response.error);
      return const Right(null);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  @override
  AsyncApiErrorOr<User> login(String email, String password) async {
    try {
      final response = await service.post(
        url: 'auth/login',
        data: {"emailAddress": email, "password": password},
      );

      if (response.hasError) return Left(response.error);
      return Right(User.fromMap(response.data!['data']));
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  @override
  AsyncApiErrorOr<void> register(RegisterData data) async {
    try {
      final response = await service.post(url: 'auth/register');

      if (response.hasError) return Left(response.error);
      return const Right(null);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  @override
  AsyncApiErrorOr<void> sendPasswordReset(String email) async {
    try {
      final response = await service.post(
        url: 'auth/reset-password',
        data: {"email": email},
      );

      if (response.hasError) return Left(response.error);
      return const Right(null);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  @override
  AsyncApiErrorOr<void> setNewPassword(SetNewPasswordData data) async {
    try {
      final response = await service.post(
        url: 'auth/reset-password',
        data: data.toMap(),
      );

      if (response.hasError) return Left(response.error);
      return const Right(null);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  @override
  AsyncApiErrorOr<void> verifyPasswordResetOTP(String otp) async {
    try {
      final response = await service.post(
        url: 'auth/verify-token',
        data: {"token": otp},
      );

      if (response.hasError) return Left(response.error);
      return const Right(null);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }
}
