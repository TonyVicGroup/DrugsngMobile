import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:drugs_ng/features/auth/data/repositories/auth_repository.dart';
import 'package:drugs_ng/features/auth/domain/models/auth_models.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileUpdateCubit extends Cubit<ProfileUpdateState> {
  final AuthRepository authRepository = AuthRepository();
  final AuthCubit authCubit;

  ProfileUpdateCubit({required this.authCubit}) : super(ProfileUpdateState());

  Future<void> updateProfile(AuthUserProfile profile) async {
    if (!authCubit.state.isLoggedIn) return;
    final currentUser = authCubit.state.account!;
    emit(state.copyWith(status: LoadStatusEnum.loading));
    final result = await authRepository.setupProfile(
      currentUser.userId,
      profile,
    );
    result.fold(
      (error) {
        emit(state.copyWith(status: LoadStatusEnum.failed, error: error));
      },
      (updatedUser) {
        emit(state.copyWith(status: LoadStatusEnum.success));
        // authCubit.updateUserInfo(profile);
      },
    );
  }
}

class ProfileUpdateState extends Equatable {
  final LoadStatusEnum status;
  final ApiError? error;

  const ProfileUpdateState({this.status = LoadStatusEnum.initial, this.error});

  ProfileUpdateState copyWith({LoadStatusEnum? status, ApiError? error}) {
    return ProfileUpdateState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, error];
}
