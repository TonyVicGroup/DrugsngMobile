import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(const NotificationState());

  Future<void> getNotification() async {}
}

class NotificationState extends Equatable {
  final List notifications;
  final LoadStatusEnum status;
  final String? error;

  const NotificationState({
    this.notifications = const [],
    this.status = LoadStatusEnum.initial,
    this.error,
  });

  @override
  List<Object?> get props => [notifications, status, error];
}
