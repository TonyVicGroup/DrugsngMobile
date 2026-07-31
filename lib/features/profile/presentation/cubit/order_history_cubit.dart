import 'dart:io';

import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:drugs_ng/features/explore/domain/models/page_filter.dart';
import 'package:drugs_ng/features/profile/data/repositories/profile_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drugs_ng/features/profile/data/models/order_history.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

part 'order_history_state.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  final ProfileRepository repo = ProfileRepository();

  static const int pageSize = 20;

  OrderHistoryCubit() : super(OrderHistoryState.initial());

  Future getInProgress({bool showLoader = false}) async {
    final account = GetIt.I.get<AuthCubit>().state.account;
    if (account == null) return;
    if (showLoader) {
      emit(state.copy(inProgressStatus: LoadStatusEnum.loading));
    }
    final result = await repo.getOrderHistory(
      userId: account.userId.toString(),
      pageFilter: PageFilter(
        pageNumber: state.inProgressPage,
        pageSize: pageSize,
      ),
      status: OrderHistoryStatus.inProgress.number.toString(),
    );
    result.fold(
      (l) {
        emit(
          state.copy(
            inProgressError: l,
            inProgressStatus: LoadStatusEnum.failed,
          ),
        );
      },
      (r) {
        emit(
          state.copy(
            inProgress: r,
            inProgressStatus: LoadStatusEnum.success,
            inProgressPage: state.inProgressPage,
          ),
        );
      },
    );
  }

  Future getSettled({bool showLoader = false}) async {
    final account = GetIt.I.get<AuthCubit>().state.account;
    if (account == null) return;
    if (showLoader) {
      emit(state.copy(settledStatus: LoadStatusEnum.loading));
    }
    final result = await repo.getOrderHistory(
      userId: account.userId.toString(),
      pageFilter: PageFilter(pageNumber: state.settledPage, pageSize: pageSize),
      status: OrderHistoryStatus.settled.number.toString(),
    );
    result.fold(
      (l) {
        emit(state.copy(settledError: l, settledStatus: LoadStatusEnum.failed));
      },
      (r) {
        emit(
          state.copy(
            settled: r,
            settledStatus: LoadStatusEnum.success,
            settledPage: state.settledPage,
          ),
        );
      },
    );
  }

  /// fetch more data for inpgrogress order history
  Future fetchMoreInProgress() async {
    final account = GetIt.I.get<AuthCubit>().state.account;
    if (account == null) return;
    int pageNumber = state.inProgressPage + 1;
    final result = await repo.getOrderHistory(
      userId: account.userId.toString(),
      pageFilter: PageFilter(pageNumber: pageNumber, pageSize: pageSize),
      status: OrderHistoryStatus.inProgress.number.toString(),
    );
    result.fold(
      (l) {
        emit(
          state.copy(
            inProgressError: l,
            inProgressStatus: LoadStatusEnum.failed,
          ),
        );
      },
      (r) {
        if (r.isEmpty) {
          /// update page number
          pageNumber -= 1;
        }
        emit(
          state.copy(
            inProgress: state.inProgress..addAll(r),
            inProgressStatus: LoadStatusEnum.success,
            inProgressPage: pageNumber,
          ),
        );
      },
    );
  }

  /// fetch more settled data
  Future fetchMoreSettled() async {
    final account = GetIt.I.get<AuthCubit>().state.account;
    if (account == null) return;
    int pageNumber = state.settledPage + 1;
    final result = await repo.getOrderHistory(
      userId: account.userId.toString(),
      pageFilter: PageFilter(pageNumber: pageNumber, pageSize: pageSize),
      status: OrderHistoryStatus.settled.number.toString(),
    );
    result.fold(
      (l) {
        emit(state.copy(settledError: l, settledStatus: LoadStatusEnum.failed));
      },
      (r) {
        if (r.isEmpty) {
          /// update page number
          pageNumber -= 1;
        }
        emit(
          state.copy(
            settled: state.settled..addAll(r),
            settledStatus: LoadStatusEnum.success,
            settledPage: pageNumber,
          ),
        );
      },
    );
  }

  void changeTab(OrderHistoryStatus tab) {
    emit(state.copy(tabStatus: tab));
  }

  void resetData() {
    emit(OrderHistoryState.initial());
  }
}
