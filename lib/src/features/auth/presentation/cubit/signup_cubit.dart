import 'package:drugs_ng/src/core/utils/app_utils.dart';
import 'package:drugs_ng/src/features/auth/data/models/signup_data.dart';
import 'package:drugs_ng/src/features/auth/presentation/pages/setup_profile_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SignupState { initial, loading, failed, success }

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupState.initial);

  Future createAccount(SignupData data) async {
    emit(SignupState.loading);
    await Future.delayed(const Duration(seconds: 2));
    emit(SignupState.success);
    AppUtils.push(const SetupProfilePage());
  }
}
