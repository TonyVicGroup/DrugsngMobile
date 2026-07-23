import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/features/auth/data/repositories/auth_repository.dart';
import 'package:drugs_ng/features/auth/domain/models/auth_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "profile_setup_state.dart";

class ProfileSetupCubit extends Cubit<ProfileSetupState> {
  final AuthRepository repo = AuthRepository();

  ProfileSetupCubit() : super(ProfileSetupInitial());

  Future updateUserInfo(int id, AuthUserProfile profile) async {
    emit(ProfileSetupLoading());
    final result = await repo.setupProfile(id, profile);

    result.fold(
      (left) => emit(ProfileSetupError(left)),
      (right) => emit(ProfileSetupUpdated()),
    );
  }
}
