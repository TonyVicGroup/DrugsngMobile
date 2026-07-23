import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/features/home/data/repositories/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drugs_ng/features/home/domain/models/home_data.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository repo = HomeRepository();
  HomeCubit() : super(const HomeInitial());

  Future getData() async {
    emit(HomeLoading(state.data));
    final result = await repo.getData();
    result.fold(
      (l) => emit(HomeError(state.data, l)),
      (r) => emit(HomeSuccess(r)),
    );
  }

  Future reloadData() async {
    final result = await repo.getData();
    result.fold(
      (l) => emit(HomeError(state.data, l)),
      (r) => emit(HomeSuccess(r)),
    );
  }
}
