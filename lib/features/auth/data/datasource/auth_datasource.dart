import 'package:dio/dio.dart';
import 'package:drugs_ng/core/enum/otp_type_enum.dart';
import 'package:drugs_ng/core/services/log_service.dart';
import 'package:drugs_ng/core/services/rest_service.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/auth/data/datasource/get_local_token.dart';
import 'package:drugs_ng/features/auth/domain/models/account_model.dart';
import 'package:drugs_ng/features/auth/domain/models/auth_models.dart';
import 'package:drugs_ng/features/auth/domain/models/user_profile_model.dart';
import 'package:drugs_ng/features/auth/domain/repositories/abstract_account.dart';

class AuthDatasource {
  final RestService _client = RestService(baseUrl: AppUtils.baseUrl);

  @override
  Future<UserProfileModel> getUserData(int id) async {
    final response = await _client.get(path: 'auth/user/$id');
    if (response.hasError) throw response.error;
    return UserAccount.fromJson(response.data!['data']);
  }

  Future<AbstractAccount> getDoctorData(int id) async {
    throw UnimplementedError();
  }

  Future<AccountModel> login(String email, String password) async {
    final response = await _client.post(
      path: 'auth/login',
      data: {"emailAddress": email, "password": password},
    );

    if (response.hasError) throw response.error;
    final account = AccountModel.fromJson(response.data!['data']);
    return account;
  }

  Future<void> signup(SignupData data) async {
    final response = await _client.post(
      path: 'auth/register',
      data: {
        "firstName": data.firstName,
        "lastName": data.lastName,
        "emailAddress": data.email,
        "password": data.password,
        "confirmPassword": data.password,
      },
    );

    if (response.hasError) throw response.error;
  }

  Future<void> setupProfile(int id, AuthUserProfile data) async {
    final formData = FormData.fromMap({
      'FirstName': data.firstName,
      'LastName': data.lastName,
      'Gender': data.gender,
      'Email': data.email,
      'Phone': data.phone,
      'DOB': data.birthday.toIso8601String().substring(0, 10),
      // 'File': MultipartFile.fromFileSync(file.path!, filename: file.name),
    });

    final response = await _client.putFormData(
      path: 'auth/$id/update-user',
      data: formData,
    );

    if (response.hasError) throw response.error;
  }

  Future<void> confirmAccount({
    required String otp,
    required String email,
  }) async {
    final response = await _client.post(
      path: 'auth/account-confirmation',
      data: {"token": otp, "emailAddress": email},
    );
    if (response.hasError) throw response.error;
  }

  Future<void> sendPasswordReset(String email) async {
    final response = await _client.post(
      path: 'auth/reset-password',
      data: {"email": email},
    );

    if (response.hasError) throw response.error;
  }

  Future<void> setNewPassword(
    String newPassword,
    String email,
    String otp,
  ) async {
    final response = await _client.put(
      path: 'auth/set-password',
      data: {
        "newPassword": newPassword,
        "confirmPassword": newPassword,
        "token": otp,
        "emailAddress": email,
      },
    );

    if (response.hasError) throw response.error;
  }

  Future<void> verifyPasswordResetOTP(String otp) async {
    final response = await _client.post(
      path: 'auth/verify-password-reset-token/$otp',
    );

    if (response.hasError) throw response.error;
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
  Future<void> resendOtp({
    required String email,
    required OtpTypeEnum otpType,
  }) async {
    final response = await _client.post(
      path: 'auth/user/resend-otp',
      data: {"email": email, "tokenType": otpType.value},
    );

    if (response.hasError) throw response.error;
  }
}
