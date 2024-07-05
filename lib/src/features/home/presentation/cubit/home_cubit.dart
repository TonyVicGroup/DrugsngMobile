import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drugs_ng/src/features/home/data/models/home_data.dart';
import 'package:drugs_ng/src/features/home/data/repositories/home_repository.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository repo;
  HomeCubit(this.repo) : super(HomeInitial());

  Future getData() async {
    emit(HomeLoading(state.data));
    final result = await repo.getData();
    result.fold(
      (l) => emit(HomeError(state.data, l.message)),
      (r) => emit(HomeSuccess(r)),
    );
  }

  Future reloadData() async {
    final result = await repo.getData();
    result.fold(
      (l) => emit(HomeError(state.data, l.message)),
      (r) => emit(HomeSuccess(r)),
    );
  }
}
