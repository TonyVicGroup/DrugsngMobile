import 'package:drugs_ng/src/core/utils/app_data_types.dart';
import 'package:drugs_ng/src/features/auth/domain/models/auth_models.dart';
import 'package:drugs_ng/src/features/auth/domain/models/user.dart';

abstract class AuthRepository {
  AsyncApiErrorOr<void> register(RegisterData data);
  AsyncApiErrorOr<User> login(String email, String password);
  AsyncApiErrorOr<void> confirmAccount(String otp);
  AsyncApiErrorOr<void> sendPasswordReset(String email);
  AsyncApiErrorOr<void> verifyPasswordResetOTP(String otp);
  AsyncApiErrorOr<void> setNewPassword(SetNewPasswordData data);
}
