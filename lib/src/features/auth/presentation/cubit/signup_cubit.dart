import 'package:drugs_ng/src/core/enum/request_status.dart';
import 'package:drugs_ng/src/core/utils/app_utils.dart';
import 'package:drugs_ng/src/features/auth/domain/models/auth_models.dart';
import 'package:drugs_ng/src/features/auth/domain/repositories/auth_repo.dart';
import 'package:drugs_ng/src/features/auth/presentation/pages/setup_profile_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SignupCubit extends Cubit<Status> {
  final AuthRepository repo;

  SignupCubit(this.repo) : super(Status.initial);

  Future createAccount(SignupData data) async {
    emit(Status.loading);
    final result = await repo.signup(data);
    result.fold(
      (left) => emit(Status.failed),
      (user) {
        emit(Status.success);
        AppUtils.pushWidget(SetupProfilePage(user: user));
      },
    );
  }
}
