import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:drugs_ng/features/checkout/data/models/address/user_address.dart';
import 'package:drugs_ng/features/checkout/data/repositories/address_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

class AddressCubit extends Cubit<AddressState> {
  final AddressRepo repo = AddressRepo();
  AddressCubit() : super(AddressState());

  Future getAddresses({bool showLoader = true}) async {
    /// refresh calls reload even when data is available
    final account = GetIt.I.get<AuthCubit>().state.account;
    if (account == null) return;

    /// else just return data already loaded
    if (showLoader) {
      emit(state.copyWith(status: LoadStatusEnum.loading));
    }
    final result = await repo.getAddreses(account.userId.toString());
    result.fold(
      (left) {
        emit(state.copyWith(status: LoadStatusEnum.failed, error: left));
      },
      (right) {
        emit(state.copyWith(addreses: right, status: LoadStatusEnum.success));
      },
    );
  }

  Future addAddress(UserAddress address) async {
    final account = GetIt.I.get<AuthCubit>().state.account;
    if (account == null) return;

    emit(state.copyWith(addEditStatus: LoadStatusEnum.loading));
    final result = await repo.addAddreses(
      address: address,
      userId: account.userId.toString(),
    );
    result.fold(
      (left) {
        emit(state.copyWith(addEditStatus: LoadStatusEnum.failed, error: left));
      },
      (right) {
        emit(
          state.copyWith(
            addreses: [...state.addreses, right],
            addEditStatus: LoadStatusEnum.success,
          ),
        );
      },
    );
  }

  Future editAddress(UserAddress address) async {
    emit(state.copyWith(addEditStatus: LoadStatusEnum.loading));
    final result = await repo.editAddreses(address);
    result.fold(
      (left) {
        emit(state.copyWith(addEditStatus: LoadStatusEnum.failed, error: left));
      },
      (right) {
        final addresses =
            state.addreses.map((e) {
              if (e.id == right.id) {
                return right;
              }
              return e;
            }).toList();
        emit(
          state.copyWith(
            addEditStatus: LoadStatusEnum.success,
            addreses: addresses,
          ),
        );
      },
    );
  }

  Future deleteAddress(UserAddress address) async {
    emit(state.copyWith(status: LoadStatusEnum.loading));
    final result = await repo.deleteAddress(address);
    result.fold(
      (left) {
        emit(state.copyWith(status: LoadStatusEnum.failed, error: left));
      },
      (right) {
        final addresses =
            state.addreses
                .where((element) => element.id != address.id)
                .toList();
        emit(
          state.copyWith(addreses: addresses, status: LoadStatusEnum.success),
        );
      },
    );
  }

  void resetData() {
    emit(const AddressState());
  }
}

class AddressState extends Equatable {
  final List<UserAddress> addreses;
  final LoadStatusEnum status;
  final LoadStatusEnum addEditStatus;
  final AppError? error;

  const AddressState({
    this.addreses = const [],
    this.status = LoadStatusEnum.initial,
    this.addEditStatus = LoadStatusEnum.initial,
    this.error,
  });

  AddressState copyWith({
    List<UserAddress>? addreses,
    LoadStatusEnum? status,
    LoadStatusEnum? addEditStatus,
    AppError? error,
  }) {
    return AddressState(
      addreses: addreses ?? this.addreses,
      status: status ?? this.status,
      addEditStatus: addEditStatus ?? this.addEditStatus,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [addreses, status, error, addEditStatus];
}
