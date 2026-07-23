// ignore_for_file: library_private_types_in_public_api

import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:drugs_ng/features/checkout/data/models/state_and_city.dart';
import 'package:drugs_ng/features/checkout/data/repositories/address_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class StateAndCityCubit extends Cubit<StateAndCityState> {
  final AddressRepo repo = AddressRepo();
  StateAndCityCubit() : super(StateAndCityState.initial());

  Future<void> getCountries() async {
    var countryDt = state.countryData.copy(status: LoadStatusEnum.loading);
    emit(state.copy(countryData: countryDt));

    // dont get countries if the data is empty
    if (state.countryData.isNotEmpty) {
      emit(
        state.copy(countryData: countryDt.copy(status: LoadStatusEnum.success)),
      );
      return;
    }

    final result = await repo.fetchCountry();
    result.fold(
      (error) {
        countryDt = countryDt.copy(status: LoadStatusEnum.failed, error: error);
        emit(state.copy(countryData: countryDt, reset: true));
      },
      (countries) {
        countryDt = countryDt.copy(
          status: LoadStatusEnum.success,
          list: countries,
        );
        emit(state.copy(countryData: countryDt));
      },
    );
  }

  Future<void> getStates() async {
    var country = state.country!;
    var stateDt = const _Data<StateModel>(
      list: [],
      status: LoadStatusEnum.loading,
    );
    if (state.stateData.containsKey(country.id.toString())) {
      if (state.stateData[country.id.toString()]!.isNotEmpty) {
        return;
      }
    }
    var data = Map<String, _Data<StateModel>>.from(state.stateData);
    data[country.id.toString()] = stateDt;
    emit(state.copy(stateData: data));
    final result = await repo.fetchState(state.country!.id);
    result.fold(
      (error) {
        stateDt = stateDt.copy(status: LoadStatusEnum.failed, error: error);
        data = Map<String, _Data<StateModel>>.from(state.stateData);
        data[country.id.toString()] = stateDt;
        emit(state.copy(stateData: data));
      },
      (states) {
        stateDt = stateDt.copy(status: LoadStatusEnum.success, list: states);
        data = Map<String, _Data<StateModel>>.from(state.stateData);
        data[country.id.toString()] = stateDt;
        emit(state.copy(stateData: data, country: state.country, reset: true));
      },
    );
  }

  Future<void> getCity() async {
    var cityDt = const _Data<CityModel>(
      list: [],
      status: LoadStatusEnum.loading,
    );
    // ignore: no_leading_underscores_for_local_identifiers
    var _state = state.state!;
    if (state.cityData.containsKey(_state.stateKey)) {
      if (state.cityData[_state.stateKey]!.isNotEmpty) {
        return;
      }
    }
    var data = Map<String, _Data<CityModel>>.from(state.cityData);
    data[_state.stateKey] = cityDt;
    emit(state.copy(cityData: data));
    final result = await repo.fetchCity(_state.id);
    result.fold(
      (error) {
        cityDt = cityDt.copy(status: LoadStatusEnum.failed, error: error);
        data[_state.stateKey] = cityDt;
        emit(state.copy(cityData: data));
      },
      (countries) {
        cityDt = cityDt.copy(status: LoadStatusEnum.success, list: countries);
        data = Map<String, _Data<CityModel>>.from(state.cityData);
        data[_state.stateKey] = cityDt;
        emit(
          state.copy(
            cityData: data,
            countryData: state.countryData,
            country: state.country,
            stateData: state.stateData,
            state: state.state,
            reset: true,
          ),
        );
      },
    );
  }

  void setCountry(CountryModel? country) => emit(state.copy(country: country));
  void setState(StateModel? state) => emit(this.state.copy(state: state));
  void setCity(CityModel? city) => emit(state.copy(city: city));
  void resetData() => emit(state.copy(reset: true));

  void setDataFromKeys({int? countryId, int? stateId, int? localGovId}) async {
    // if country is empty fetch country data
    if (state.countryData.isEmpty) {
      await getCountries();
    }
    final country = state.countryData.list.where(
      (cntry) => cntry.id == countryId,
    );
    if (country.isEmpty) {
      return;
    }
    final selectedCountry = country.first;
    emit(state.copy(country: selectedCountry));
    if (stateId == null) return;
    var stateList = state.stateData[selectedCountry.id.toString()]?.list ?? [];
    // fetch list of states if the state is empty
    if (stateList.isEmpty) {
      await getStates();
    }
    final states =
        state.stateData[selectedCountry.id.toString()]?.list.where(
          (st) => st.id == stateId,
        ) ??
        [];
    if (states.isEmpty) return;
    final selectedState = states.first;
    emit(state.copy(state: selectedState));
    if (localGovId == null) return;
    var localGovList = state.cityData[selectedState.stateKey]?.list ?? [];
    // fetch list of local governments if it is empty
    if (localGovList.isEmpty) {
      await getCity();
    }
    final cities =
        state.cityData[selectedState.stateKey]?.list.where(
          (ct) => ct.id == localGovId,
        ) ??
        [];
    if (cities.isEmpty) return;
    emit(state.copy(city: cities.first));
  }
}

class StateAndCityState extends Equatable {
  final _Data<CountryModel> countryData;
  final Map<String, _Data<CityModel>> cityData;
  final Map<String, _Data<StateModel>> stateData;
  final CountryModel? country;
  final StateModel? state;
  final CityModel? city;
  final String? forceUpdateKey;

  const StateAndCityState({
    required this.countryData,
    required this.cityData,
    required this.stateData,
    this.country,
    this.state,
    this.city,
    this.forceUpdateKey,
  });

  factory StateAndCityState.initial() => const StateAndCityState(
    countryData: _Data<CountryModel>(list: []),
    cityData: <String, _Data<CityModel>>{},
    stateData: <String, _Data<StateModel>>{},
  );

  // getters
  _Data<StateModel> get allStates =>
      stateData[country?.id.toString() ?? ''] ??
      const _Data<StateModel>(list: []);
  _Data<CityModel> get allCities =>
      cityData[state?.stateKey ?? ''] ?? const _Data<CityModel>(list: []);

  StateAndCityState copy({
    bool reset = false,
    _Data<CountryModel>? countryData,
    Map<String, _Data<CityModel>>? cityData,
    Map<String, _Data<StateModel>>? stateData,
    CountryModel? country,
    StateModel? state,
    CityModel? city,
  }) {
    return StateAndCityState(
      countryData: countryData ?? this.countryData,
      cityData: cityData ?? this.cityData,
      stateData: stateData ?? this.stateData,
      country: reset ? country : (country ?? this.country),
      state: reset ? state : (state ?? this.state),
      city: reset ? city : (city ?? this.city),
      forceUpdateKey: const Uuid().v8(),
    );
  }

  @override
  List<Object?> get props => [
    countryData,
    cityData,
    stateData,
    country,
    state,
    city,
    forceUpdateKey,
  ];
}

class _Data<T> extends Equatable {
  final LoadStatusEnum status;
  final List<T> list;
  final ApiError? error;

  const _Data({
    this.status = LoadStatusEnum.initial,
    required this.list,
    this.error,
  });

  // getters
  bool get isEmpty => list.isEmpty;
  bool get isNotEmpty => list.isNotEmpty;

  _Data<T> copy({LoadStatusEnum? status, List<T>? list, ApiError? error}) =>
      _Data<T>(
        status: status ?? this.status,
        list: list ?? this.list,
        error: error,
      );

  @override
  List<Object?> get props => [status, list, error];
}
