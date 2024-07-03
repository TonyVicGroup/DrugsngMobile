import 'package:drugs_ng/src/core/utils/app_data_types.dart';
import 'package:drugs_ng/src/features/auth/domain/models/auth_models.dart';
import 'package:drugs_ng/src/features/auth/domain/models/user.dart';

abstract class AuthRepo {
  AsyncErrorOr<void> register(RegisterData data);
  AsyncErrorOr<User> login(String email, String password);
  AsyncErrorOr<void> confirmAccount(String otp);
  AsyncErrorOr<void> sendPasswordReset(String email);
  AsyncErrorOr<void> verifyPasswordResetOTP(String otp);
  AsyncErrorOr<void> setNewPassword(SetNewPasswordData data);
}
