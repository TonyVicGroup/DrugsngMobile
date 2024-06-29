import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drugs_ng/features/home/data/models/home_data.dart';
import 'package:drugs_ng/features/home/data/repositories/home_repository.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repo;

  HomeBloc(this.repo) : super(const HomeInitial()) {
    on<GetHomeData>(_getData);
    on<ReloadHomeData>(_reloadData);
  }

  void _getData(GetHomeData event, Emitter<HomeState> emit) async {
    emit(HomeLoading(state.data));
    final result = await repo.getData();
    result.fold(
      (l) => emit(HomeError(state.data, l.message)),
      (r) => emit(HomeSuccess(r)),
    );
  }

  void _reloadData(ReloadHomeData event, Emitter<HomeState> emit) async {
    final result = await repo.getData();
    result.fold(
      (l) => emit(HomeError(state.data, l.message)),
      (r) => emit(HomeSuccess(r)),
    );
  }
}
