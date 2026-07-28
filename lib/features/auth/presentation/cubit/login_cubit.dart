import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:drugs_ng/features/auth/data/datasource/user_preference.dart';
import 'package:drugs_ng/features/auth/data/repositories/auth_repository.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository repo = AuthRepository();
  final LocalAuthentication _localAuth = LocalAuthentication();
  LoginCubit() : super(LoginState()) {
    init();
  }

  void init() {
    final userData = UserPreference.getUser();
    emit(
      state.copyWith(
        // hasBiometricSensor: userData.hasBiometricSensor,
        isBiometricEnabled: userData.setBiometric,
        status: LoadStatusEnum.initial,
      ),
    );
  }

  void setupBiometric() {
    emit(state.copyWith(isBiometricEnabled: true));
  }

  Future<void> biometricLogin() async {
    final userData = UserPreference.getUser();
    final email = userData.email;
    final password = userData.password;
    if (email == null || password == null) {
      emit(
        state.copyWith(
          error:
              "No credentials found for biometric login, please login using your email and password",
          status: LoadStatusEnum.failed,
        ),
      );
      return;
    }

    // Check if the device supports biometrics
    final bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
    final bool isDeviceSupported = await _localAuth.isDeviceSupported();
    if (!canCheckBiometrics || !isDeviceSupported) {
      emit(
        state.copyWith(
          error: "Biometric authentication is not available on this device",
          status: LoadStatusEnum.failed,
        ),
      );
      return;
    }

    // Prompt biometric verification before logging in
    final bool authenticated = await _localAuth.authenticate(
      localizedReason: 'Verify your identity to log in',
      options: const AuthenticationOptions(
        biometricOnly: true,
        stickyAuth: true,
      ),
    );

    if (!authenticated) {
      emit(
        state.copyWith(
          error: "Biometric authentication failed or was cancelled",
          status: LoadStatusEnum.failed,
        ),
      );
      return;
    }

    login(email, password);
  }

  Future<void> login(String email, String password) async {
    emit(LoginState(status: LoadStatusEnum.loading));
    final result = await repo.login(email, password);
    result.fold(
      (error) {
        emit(LoginState(error: error.message, status: LoadStatusEnum.failed));
      },
      (result) async {
        await GetIt.I.get<AuthCubit>().loginAccount(
          email: email,
          password: password,
          account: result,
          setBiometric: state.isBiometricEnabled,
        );
        emit(LoginState(status: LoadStatusEnum.success));
      },
    );
  }

  void reset() {
    emit(LoginState());
    init();
  }
}

class LoginState extends Equatable {
  final bool hasBiometricSensor;
  final bool isBiometricEnabled;
  final String? error;
  final LoadStatusEnum status;

  const LoginState({
    this.error,
    this.status = LoadStatusEnum.initial,
    this.hasBiometricSensor = false,
    this.isBiometricEnabled = false,
  });

  LoginState copyWith({
    String? error,
    LoadStatusEnum? status,
    bool? hasBiometricSensor,
    bool? isBiometricEnabled,
  }) {
    return LoginState(
      error: error ?? this.error,
      status: status ?? this.status,
      hasBiometricSensor: hasBiometricSensor ?? this.hasBiometricSensor,
      isBiometricEnabled: isBiometricEnabled ?? this.isBiometricEnabled,
    );
  }

  @override
  List<Object?> get props => [
    error,
    status,
    isBiometricEnabled,
    hasBiometricSensor,
  ];
}
