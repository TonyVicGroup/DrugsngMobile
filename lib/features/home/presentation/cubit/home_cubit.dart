import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:drugs_ng/features/home/data/repositories/home_repository.dart';
import 'package:drugs_ng/features/product/data/repositories/product_repository.dart';
import 'package:drugs_ng/features/product/domain/models/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drugs_ng/features/home/domain/models/home_data.dart';
import 'package:equatable/equatable.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository repo = HomeRepository();
  final ProductRepository prodRepo = ProductRepository();
  HomeCubit() : super(const HomeState());

  Future getData({bool showLoader = true}) async {
    if (showLoader) emit(state.copyWith(status: LoadStatusEnum.loading));
    final result = await prodRepo.getHomePageProducts();
    // final result = await repo.getData();
    result.fold(
      (l) => emit(state.copyWith(status: LoadStatusEnum.failed)),
      (r) => emit(state.copyWith(data: r, status: LoadStatusEnum.success)),
    );
  }
}

class HomeState extends Equatable {
  final HomeData? data;
  final String? error;
  final LoadStatusEnum status;

  const HomeState({
    this.data,
    this.error,
    this.status = LoadStatusEnum.initial,
  });

  bool get isEmpty =>
      (data?.newArrivals ?? []).isEmpty && (data?.bestSellers ?? []).isEmpty;

  HomeState copyWith({HomeData? data, LoadStatusEnum? status}) {
    return HomeState(
      data: data ?? this.data,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  List<Product> get newArrivals => data?.newArrivals ?? [];
  List<Product> get bestSellers => data?.bestSellers ?? [];

  @override
  List<Object?> get props => [data, status, error];
}
