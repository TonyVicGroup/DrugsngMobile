import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:drugs_ng/features/checkout/data/models/state_and_city.dart';
import 'package:drugs_ng/features/checkout/data/repositories/address_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

class AddressCityCubit extends Cubit<AddressCityState> {
  final AddressRepo repo = AddressRepo();
  AddressCityCubit() : super(AddressCityState.initial());

  Future getCountry() async {
    if (state.countries.isNotEmpty) {
      emit(state.copy(countryStatus: LoadStatusEnum.loading));
      final result = await repo.fetchCountry();
      result.fold(
        (left) {
          emit(state.copy(countryStatus: LoadStatusEnum.failed));
        },
        (countries) {
          emit(
            state.copy(
              countryStatus: LoadStatusEnum.success,
              countries: countries,
            ),
          );
        },
      );
    }
  }

  Future getState() async {
    if (state.states.isNotEmpty && (state.countryIndex != null)) {
      emit(state.copy(stateStatus: LoadStatusEnum.loading));
      final result = await repo.fetchState(state.countryIndex!);
      result.fold(
        (left) {
          emit(state.copy(stateStatus: LoadStatusEnum.failed));
        },
        (states) {
          emit(state.copy(stateStatus: LoadStatusEnum.success, states: states));
        },
      );
    }
  }

  Future getCity() async {
    if (state.cities.isNotEmpty && (state.stateIndex != null)) {
      emit(state.copy(stateStatus: LoadStatusEnum.loading));
      final result = await repo.fetchCity(state.stateIndex!);
      result.fold(
        (left) {
          emit(state.copy(stateStatus: LoadStatusEnum.failed));
        },
        (cities) {
          emit(state.copy(stateStatus: LoadStatusEnum.success, cities: cities));
        },
      );
    }
  }
}

class AddressCityState extends Equatable {
  final List<CountryModel> countries;
  final Map<int, List<StateModel>> states;
  final Map<int, List<CityModel>> cities;
  final int? countryIndex;
  final int? stateIndex;
  final LoadStatusEnum countryStatus;
  final LoadStatusEnum stateStatus;
  final LoadStatusEnum cityStatus;

  const AddressCityState({
    required this.countries,
    required this.states,
    required this.cities,
    required this.countryStatus,
    required this.stateStatus,
    required this.cityStatus,
    this.countryIndex,
    this.stateIndex,
  });

  factory AddressCityState.initial() => const AddressCityState(
    countries: [],
    states: {},
    cities: {},
    countryStatus: LoadStatusEnum.initial,
    stateStatus: LoadStatusEnum.initial,
    cityStatus: LoadStatusEnum.initial,
  );

  AddressCityState copy({
    List<CountryModel>? countries,
    List<StateModel>? states,
    List<CityModel>? cities,
    int? countryIndex,
    int? stateIndex,
    LoadStatusEnum? countryStatus,
    LoadStatusEnum? stateStatus,
    LoadStatusEnum? cityStatus,
  }) {
    final cityMap =
        (cities == null) ? this.cities : this.cities
          ..addAll({this.stateIndex!: cities!});
    final stateMap =
        (states == null) ? this.states : this.states
          ..addAll({this.countryIndex!: states!});
    return AddressCityState(
      countries: countries ?? this.countries,
      states: stateMap,
      cities: cityMap,
      countryIndex: countryIndex ?? countryIndex,
      stateIndex: stateIndex ?? stateIndex,
      countryStatus: countryStatus ?? this.countryStatus,
      stateStatus: stateStatus ?? this.stateStatus,
      cityStatus: cityStatus ?? this.cityStatus,
    );
  }

  @override
  List<Object?> get props => [
    countries,
    states,
    cities,
    countryStatus,
    stateStatus,
    cityStatus,
  ];
}
