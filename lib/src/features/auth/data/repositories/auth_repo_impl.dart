import 'package:drugs_ng/src/core/data/models/app_responses.dart';
import 'package:drugs_ng/src/core/utils/app_data_types.dart';
import 'package:drugs_ng/src/core/utils/rest_service.dart';
import 'package:drugs_ng/src/features/auth/data/datasource/get_local_token.dart';
import 'package:drugs_ng/src/features/auth/domain/models/auth_models.dart';
import 'package:drugs_ng/src/features/auth/domain/models/user.dart';
import 'package:drugs_ng/src/features/auth/domain/repositories/auth_repo.dart';
import 'package:either_dart/either.dart';

class AuthRepositoryImpl extends AuthRepository {
  final RestService service;
  AuthRepositoryImpl(this.service);

  @override
  AsyncApiErrorOr<UserData> getUserData(int id) async {
    try {
      final response = await service.get(path: 'auth/user/$id');

      if (response.hasError) return Left(response.error);

      return Right(UserData.fromMap(response.data!['data']));
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  @override
  AsyncApiErrorOr<User> login(String email, String password) async {
    try {
      final response = await service.post(
        path: 'auth/login',
        data: {"emailAddress": email, "password": password},
      );

      // return Right(User(
      //   id: 0,
      //   authToken: '',
      //   refreshToken: '',
      //   isEmailConfirmed: true,
      //   data: UserData(
      //     id: 0,
      //     firstName: 'Eric',
      //     lastName: 'Onyeulo',
      //     email: email,
      //   ),
      // ));

      if (response.hasError) return Left(response.error);

      final user = User.fromMap(response.data!['data']);
      UserPreference.updateToken(token: user.authToken);

      final userData = await getUserData(user.id);
      userData.fold((left) => null, (data) => user.data = data);

      return Right(user);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  @override
  AsyncApiErrorOr<UserData> signup(SignupData data) async {
    try {
      final response = await service.post(
        path: 'auth/register',
        data: {
          "firstName": "_",
          "lastName": "_",
          "emailAddress": data.email,
          "password": data.password,
          "confirmPassword": data.password,
        },
      );

      if (response.hasError) return Left(response.error);
      return Right(UserData.fromMap(response.data!['data']));
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  @override
  AsyncApiErrorOr<void> setupProfile(int id, AuthUserProfile data) async {
    try {
      final response = await service.put(
        path: 'auth/$id/update-user',
        data: data.toMap(),
      );

      if (response.hasError) return Left(response.error);
      return const Right(null);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  @override
  AsyncApiErrorOr<void> confirmAccount(String otp) async {
    try {
      final response = await service.post(
        path: 'auth/account-confirmation',
        data: {"token": otp},
      );

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
        path: 'auth/reset-password',
        data: {"email": email},
      );

      if (response.hasError) return Left(response.error);
      return const Right(null);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  @override
  AsyncApiErrorOr<void> setNewPassword(String newPassword, String otp) async {
    try {
      final response = await service.put(
        path: 'auth/set-password',
        data: {
          "newPassword": newPassword,
          "confirmPassword": newPassword,
          "token": otp,
        },
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
        path: 'auth/verify-password-reset-token/$otp',
      );

      if (response.hasError) return Left(response.error);
      return const Right(null);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }
}
