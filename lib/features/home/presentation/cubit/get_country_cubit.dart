import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:drugs_ng/features/home/data/repositories/home_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetCountryCubit extends Cubit<GetCountryState> {
  final HomeRepository homeRepository = HomeRepository();

  GetCountryCubit() : super(const GetCountryState(country: 'Not Found'));

  Future<void> fetchCountry() async {
    emit(state.copyWith(status: LoadStatusEnum.loading));
    final result = await homeRepository.getCountry();
    result.fold(
      (error) {
        emit(
          state.copyWith(
            country: 'Not Found',
            status: LoadStatusEnum.failed,
            error: error,
          ),
        );
      },
      (country) {
        emit(state.copyWith(country: country, status: LoadStatusEnum.success));
      },
    );
  }
}

class GetCountryState extends Equatable {
  final String country;
  final LoadStatusEnum status;
  final ApiError? error;

  const GetCountryState({
    required this.country,
    this.status = LoadStatusEnum.initial,
    this.error,
  });

  GetCountryState copyWith({
    String? country,
    LoadStatusEnum? status,
    ApiError? error,
  }) {
    return GetCountryState(
      country: country ?? this.country,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [country, status, error];
}
