part of "profile_setup_cubit.dart";

abstract class ProfileSetupState extends Equatable {
  const ProfileSetupState();
  @override
  List<Object?> get props => [];
}

class ProfileSetupInitial extends ProfileSetupState {}

class ProfileSetupError extends ProfileSetupState {
  final String message;

  const ProfileSetupError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileSetupLoading extends ProfileSetupState {}

class ProfileSetupUpdated extends ProfileSetupState {}

class ProfileSetupPermissionDenied extends ProfileSetupState {
  final String message;
  const ProfileSetupPermissionDenied(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileSetupPermissionGranted extends ProfileSetupState {}
