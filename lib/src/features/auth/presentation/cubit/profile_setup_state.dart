part of "profile_setup_cubit.dart";

abstract class ProfileSetupState extends Equatable {
  const ProfileSetupState();
  @override
  List<Object?> get props => [];
}

class ProfileSetupInitial extends ProfileSetupState {}

class ProfileSetupError extends ProfileSetupState {
  final AppError error;

  const ProfileSetupError(this.error);

  @override
  List<Object?> get props => [error];
}

class ProfileSetupLoading extends ProfileSetupState {}

class ProfileSetupUpdated extends ProfileSetupState {}

class ProfileSetupPermissionDenied extends ProfileSetupState {
  final AppError error;
  const ProfileSetupPermissionDenied(this.error);

  @override
  List<Object?> get props => [error];
}

class ProfileSetupPermissionGranted extends ProfileSetupState {}
