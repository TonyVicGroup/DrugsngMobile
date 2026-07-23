import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:drugs_ng/features/profile/data/models/order_detail_model.dart';
import 'package:drugs_ng/features/profile/data/repositories/profile_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailCubit extends Cubit<OrderDetailState> {
  final ProfileRepository repo = ProfileRepository();

  OrderDetailCubit(int orderId) : super(OrderDetailState(orderId: orderId));

  Future getDetail({bool showLoader = false}) async {
    if (showLoader) {
      emit(state.copyWith(status: LoadStatusEnum.loading));
    }
    final result = await repo.getOrderDetails(state.orderId);
    result.fold(
      (l) {
        emit(state.copyWith(error: l, status: LoadStatusEnum.failed));
      },
      (r) {
        emit(state.copyWith(orderDetail: r, status: LoadStatusEnum.success));
      },
    );
  }
}

class OrderDetailState extends Equatable {
  final int orderId;
  final OrderDetailModel? orderDetail;
  final ApiError? error;
  final LoadStatusEnum status;

  const OrderDetailState({
    required this.orderId,
    this.orderDetail,
    this.error,
    this.status = LoadStatusEnum.initial,
  });

  OrderDetailState copyWith({
    OrderDetailModel? orderDetail,
    ApiError? error,
    LoadStatusEnum? status,
  }) {
    return OrderDetailState(
      orderId: orderId,
      orderDetail: orderDetail ?? this.orderDetail,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [orderId, orderDetail, error, status];
}
