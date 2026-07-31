part of 'order_history_cubit.dart';

enum OrderHistoryStatus {
  inProgress,
  settled;

  int get number {
    switch (this) {
      case inProgress:
        return 2;
      case settled:
        return 1;
    }
  }

  bool get isInProgress => this == inProgress;
  bool get isSettled => this == settled;

  String get displayName => switch (this) {
    inProgress => 'In Progress',
    settled => 'Settled',
  };

  @override
  String toString() => displayName;
}

class OrderHistoryState extends Equatable {
  const OrderHistoryState({
    required this.inProgress,
    required this.settled,
    required this.inProgressPage,
    required this.settledPage,
    required this.tabStatus,
    required this.inProgressError,
    required this.settledError,
    required this.inProgressStatus,
    required this.settledStatus,
  });

  factory OrderHistoryState.initial() => const OrderHistoryState(
    inProgress: [],
    settled: [],
    inProgressPage: 0,
    settledPage: 0,
    tabStatus: OrderHistoryStatus.inProgress,
    inProgressStatus: LoadStatusEnum.initial,
    settledStatus: LoadStatusEnum.initial,
    inProgressError: null,
    settledError: null,
  );

  final OrderHistoryStatus tabStatus;
  final List<OrderHistory> inProgress;
  final List<OrderHistory> settled;
  final LoadStatusEnum inProgressStatus;
  final LoadStatusEnum settledStatus;
  final int inProgressPage;
  final int settledPage;
  final AppError? inProgressError;
  final AppError? settledError;

  OrderHistoryState copy({
    OrderHistoryStatus? tabStatus,
    List<OrderHistory>? inProgress,
    List<OrderHistory>? settled,
    int? inProgressPage,
    int? settledPage,
    AppError? inProgressError,
    AppError? settledError,
    LoadStatusEnum? inProgressStatus,
    LoadStatusEnum? settledStatus,
  }) => OrderHistoryState(
    inProgress: inProgress ?? this.inProgress,
    settled: settled ?? this.settled,
    inProgressPage: inProgressPage ?? this.inProgressPage,
    settledPage: settledPage ?? this.settledPage,
    tabStatus: tabStatus ?? this.tabStatus,
    inProgressError: inProgressError ?? this.inProgressError,
    settledError: settledError ?? this.settledError,
    inProgressStatus: inProgressStatus ?? this.inProgressStatus,
    settledStatus: settledStatus ?? this.settledStatus,
  );

  @override
  List<Object> get props => [
    tabStatus,
    inProgress,
    settled,
    inProgressPage,
    settledPage,
    inProgressError ?? "",
    settledError ?? "",
    inProgressStatus,
    settledStatus,
  ];

  /// function to check if the current state (settled or in progress)
  ///  is loaded
  bool stateNotLoaded() {
    if (tabStatus.isInProgress) {
      return inProgressStatus.isInitial;
    } else {
      return settledStatus.isInitial;
    }
  }
}
