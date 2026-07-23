// ignore_for_file: library_private_types_in_public_api

import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:drugs_ng/features/consultation/data/models/consultation_details.dart';
import 'package:drugs_ng/features/consultation/data/models/consultation_parameters.dart';
import 'package:drugs_ng/features/consultation/data/repository/consultation_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

class UserConsultationsCubit extends Cubit<UserConsultationsState> {
  final ConsultationRepository repo = ConsultationRepository();
  UserConsultationsCubit() : super(UserConsultationsState.initial());

  Future<void> getConsultations({bool showLoader = true}) async {
    final status = state.status;
    var dt = state.current;
    if (showLoader) {
      emit(state.copy(data: dt.copy(loadStatus: LoadStatusEnum.loading)));
    }
    final result = await repo.getConsultations(dt.params(state.status.name));
    result.fold(
      (left) {
        emit(
          state.copy(
            data: dt.copy(
              message: left.message,
              loadStatus: LoadStatusEnum.failed,
            ),
          ),
        );
      },
      (right) {
        emit(
          state.copy(
            status: status,
            data: dt.copy(
              list: right,
              loadStatus: LoadStatusEnum.success,
              pageNumber: dt.pageNumber + 1,
            ),
          ),
        );
      },
    );
  }

  void changeTab(int index) {
    if (index == 0) {
      emit(state.copy(status: ConsultStatusEnum.pending));
    } else if (index == 1) {
      emit(state.copy(status: ConsultStatusEnum.ongoing));
    } else {
      emit(state.copy(status: ConsultStatusEnum.completed));
    }
    if (state.current.list.isEmpty) {
      getConsultations();
    }
  }

  void resetData() {
    emit(UserConsultationsState.initial());
  }
}

enum ConsultStatusEnum {
  pending,
  ongoing,
  completed;

  String get name => switch (this) {
    pending => 'Pending',
    ongoing => 'Ongoing',
    completed => 'Completed',
  };

  bool get isPending => this == pending;
  bool get isOngoing => this == ongoing;
  bool get isCompleted => this == completed;
}

class UserConsultationsState extends Equatable {
  final ConsultStatusEnum status;
  final _Data pending;
  final _Data ongoing;
  final _Data completed;

  const UserConsultationsState({
    required this.status,
    required this.pending,
    required this.ongoing,
    required this.completed,
  });

  factory UserConsultationsState.initial() => const UserConsultationsState(
    status: ConsultStatusEnum.pending,
    pending: _Data(),
    ongoing: _Data(),
    completed: _Data(),
  );

  _Data get current => switch (status) {
    ConsultStatusEnum.pending => pending,
    ConsultStatusEnum.ongoing => ongoing,
    ConsultStatusEnum.completed => completed,
  };

  int get totalConsultations =>
      pending.list.length + completed.list.length + ongoing.list.length;

  UserConsultationsState copy({ConsultStatusEnum? status, _Data? data}) {
    final stat = status ?? this.status;
    return UserConsultationsState(
      status: stat,
      pending: stat.isPending ? (data ?? pending) : pending,
      ongoing: stat.isOngoing ? (data ?? ongoing) : ongoing,
      completed: stat.isCompleted ? (data ?? completed) : completed,
    );
  }

  @override
  List<Object?> get props => [status, pending, ongoing, completed];
}

class _Data extends Equatable {
  final List<ConsultationDetails> list;
  final int pageNumber;
  final LoadStatusEnum loadStatus;
  final String? message;
  static const int _pageSize = 20;

  const _Data({
    this.list = const [],
    this.loadStatus = LoadStatusEnum.initial,
    this.message,
    this.pageNumber = 1,
  });

  _Data copy({
    List<ConsultationDetails>? list,
    LoadStatusEnum? loadStatus,
    String? message,
    int? pageNumber,
  }) => _Data(
    list: list ?? this.list,
    loadStatus: loadStatus ?? this.loadStatus,
    pageNumber: pageNumber ?? this.pageNumber,
    message: message,
  );

  ConsultationParameters params(String status) =>
      ConsultationParameters(null, status, pageNumber, _pageSize);

  @override
  List<Object?> get props => [list, loadStatus, message, pageNumber];
}
