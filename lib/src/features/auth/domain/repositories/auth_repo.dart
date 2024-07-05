import 'package:drugs_ng/src/core/utils/app_data_types.dart';
import 'package:drugs_ng/src/features/auth/domain/models/auth_models.dart';
import 'package:drugs_ng/src/features/auth/domain/models/user.dart';

abstract class AuthRepository {
  AsyncApiErrorOr<User> signup(SignupData data);
  AsyncApiErrorOr<User> login(String email, String password);
  AsyncApiErrorOr<User> getUserData(int id);
  AsyncApiErrorOr<void> setupProfile(int id, AuthUserProfile data);
  AsyncApiErrorOr<void> confirmAccount(String otp);
  AsyncApiErrorOr<void> sendPasswordReset(String email);
  AsyncApiErrorOr<void> verifyPasswordResetOTP(String otp);
  AsyncApiErrorOr<void> setNewPassword(String newPassword, String otp);
}
