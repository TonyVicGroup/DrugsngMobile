import 'package:drugs_ng/core/enum/account_type_enum.dart';
import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:drugs_ng/features/auth/data/datasource/get_local_token.dart';
import 'package:drugs_ng/features/auth/data/repositories/auth_repository.dart';
import 'package:drugs_ng/features/auth/domain/models/account_model.dart';
import 'package:drugs_ng/features/delivery/data/models/delivery_profile_model.dart';
import 'package:drugs_ng/features/doctor/data/models/doctor_profile_model.dart';
import 'package:drugs_ng/features/auth/domain/models/lab_profile_model.dart';
import 'package:drugs_ng/features/auth/domain/models/user_profile_model.dart';
import 'package:drugs_ng/features/doctor/data/repositories/doctor_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepo = AuthRepository();
  final DoctorRepository _doctorRepo = DoctorRepository();
  // final LabRepository _labRepo = LabRepository();
  // final DeliveryRepository _deliveryRepo = DeliveryRepository();

  AuthCubit() : super(AuthState());

  bool get isLoggedIn => state.user != null;

  /// Login using saved token
  /// if token has expired or is invalid, user will be logged out
  Future<void> tokenLogin() async {
    final account = UserPreference.getUser();
    if (account == null) {
      return;
    }
    await getProfile(account);
  }

  /// logout from account
  Future<void> logout() async {
    UserPreference.reset();
    emit(AuthState());
  }

  Future<void> getProfile(AccountModel account) async {
    emit(state.copyWith(account: account, status: LoadStatusEnum.loading));
    if (account.accountType.isDoctor) {
      await getDoctorProfile(account.userId);
    } else if (account.accountType.isDelivery) {
      await getDeliveryProfile(account.userId);
    } else {
      await getUserProfile(account.userId);
    }
  }

  Future<void> getDoctorProfile(int userId) async {
    final result = await _doctorRepo.getDoctor(userId);
    await result.fold(
      (error) async {
        emit(
          state.copyWith(status: LoadStatusEnum.failed, error: error.message),
        );
      },
      (accountData) async {
        emit(
          state.copyWith(doctor: accountData, status: LoadStatusEnum.loading),
        );
      },
    );
  }

  Future<void> getDeliveryProfile(int userId) async {
    // final result = await _deliveryRepo.getDeliveryProfile(userId);
    // result.fold(
    //   (error) {
    //     emit(
    //       state.copyWith(status: LoadStatusEnum.failed, error: error.message),
    //     );
    //   },
    //   (accountData) {
    //     emit(
    //       state.copyWith(delivery: accountData, status: LoadStatusEnum.loading),
    //     );
    //   },
    // );
  }

  Future<void> getUserProfile(int userId) async {
    final result = await _authRepo.getUserData(userId);
    result.fold(
      (error) {
        emit(
          state.copyWith(status: LoadStatusEnum.failed, error: error.message),
        );
      },
      (accountData) {
        emit(state.copyWith(user: accountData, status: LoadStatusEnum.loading));
      },
    );
  }

  /// get account type
  AccountTypeEnum? get accountType => state.accountType;
}

class AuthState extends Equatable {
  final UserProfileModel? user;
  final DoctorProfileModel? doctor;
  final DeliveryProfileModel? delivery;
  final AccountModel? account;
  final AccountTypeEnum? accountType;
  final String? error;
  final LoadStatusEnum status;

  const AuthState({
    this.user,
    this.doctor,
    this.account,
    this.delivery,
    this.accountType,
    this.error,
    this.status = LoadStatusEnum.initial,
  });

  bool get isLoggedIn => user != null || doctor != null || delivery != null;

  AuthState copyWith({
    UserProfileModel? user,
    DoctorProfileModel? doctor,
    DeliveryProfileModel? delivery,
    AccountModel? account,
    AccountTypeEnum? accountType,
    String? error,
    LoadStatusEnum? status,
  }) {
    return AuthState(
      user: user ?? this.user,
      doctor: doctor ?? this.doctor,
      account: account ?? this.account,
      accountType: accountType ?? this.accountType,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
    user,
    doctor,
    account,
    accountType,
    error,
    status,
  ];
}
