import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:drugs_ng/features/explore/domain/models/page_filter.dart';
import 'package:drugs_ng/features/profile/data/repositories/profile_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drugs_ng/features/profile/data/models/order_history.dart';
import 'package:equatable/equatable.dart';

part 'order_history_state.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  final ProfileRepository repo = ProfileRepository();

  static const int pageSize = 20;

  OrderHistoryCubit() : super(OrderHistoryState.initial());

  Future getInProgress({bool showLoader = false}) async {
    if (showLoader) {
      emit(state.copy(inProgressStatus: LoadStatusEnum.loading));
    }
    final result = await repo.getOrderHistory(
      PageFilter(pageNumber: state.inProgressPage, pageSize: pageSize),
      OrderHistoryStatus.inProgress.number.toString(),
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
    if (showLoader) {
      emit(state.copy(settledStatus: LoadStatusEnum.loading));
    }
    final result = await repo.getOrderHistory(
      PageFilter(pageNumber: state.settledPage, pageSize: pageSize),
      OrderHistoryStatus.settled.number.toString(),
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
    int pageNumber = state.inProgressPage + 1;
    final result = await repo.getOrderHistory(
      PageFilter(pageNumber: pageNumber, pageSize: pageSize),
      OrderHistoryStatus.inProgress.number.toString(),
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
    int pageNumber = state.settledPage + 1;
    final result = await repo.getOrderHistory(
      PageFilter(pageNumber: pageNumber, pageSize: pageSize),
      OrderHistoryStatus.settled.number.toString(),
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

  void changeTab(bool tab) {
    emit(
      state.copy(
        tabStatus:
            tab ? OrderHistoryStatus.inProgress : OrderHistoryStatus.settled,
      ),
    );
  }

  void resetData() {
    emit(OrderHistoryState.initial());
  }
}
