import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/core/enum/otp_type_enum.dart';
import 'package:drugs_ng/core/utils/app_data_types.dart';
import 'package:drugs_ng/features/auth/data/datasource/auth_datasource.dart';
import 'package:drugs_ng/features/auth/domain/models/account_model.dart';
import 'package:drugs_ng/features/auth/domain/models/auth_models.dart';
import 'package:drugs_ng/features/doctor/data/models/doctor_profile_model.dart';
import 'package:drugs_ng/features/auth/domain/models/user_profile_model.dart';
import 'package:drugs_ng/features/auth/domain/repositories/abstract_account.dart';

import 'package:either_dart/either.dart';

class AuthRepository {
  final AuthDatasource datasource = AuthDatasource();

  AsyncApiErrorOr<UserProfileModel> getUserData(int id) async {
    try {
      final result = await datasource.getUserData(id);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<DoctorProfileModel> getDoctorData(int id) async {
    return const Left(ApiError.unknown);
  }

  AsyncApiErrorOr<AccountModel> login(String email, String password) async {
    try {
      final result = await datasource.login(email, password);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<void> signup(SignupData data) async {
    try {
      final result = await datasource.signup(data);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<void> setupProfile(int id, AuthUserProfile data) async {
    try {
      final result = await datasource.setupProfile(id, data);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<void> confirmAccount({
    required String otp,
    required String email,
  }) async {
    try {
      final result = await datasource.confirmAccount(otp: otp, email: email);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<void> sendPasswordReset(String email) async {
    try {
      final result = await datasource.sendPasswordReset(email);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<void> setNewPassword(
    String newPassword,
    String email,
    String otp,
  ) async {
    try {
      final result = await datasource.setNewPassword(newPassword, email, otp);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<void> verifyPasswordResetOTP(String otp) async {
    try {
      final result = await datasource.verifyPasswordResetOTP(otp);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  ///"tokenType" ->
  ///
  /// Email_Confirmation = 1,
  ///
  /// Password_Reset = 2,
  ///
  /// Login_Confirmation = 3,
  ///
  /// Phone_Confirmation,
  AsyncApiErrorOr<void> resendOtp(String email, OtpTypeEnum otpType) async {
    try {
      final result = await datasource.resendOtp(email: email, otpType: otpType);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }
}
