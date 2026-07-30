import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:drugs_ng/features/explore/data/repository/explore_repository.dart';
import 'package:drugs_ng/features/explore/domain/models/generic_brand_name.dart';
import 'package:drugs_ng/features/explore/domain/models/page_filter.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

enum ExploreNameEnum {
  brand,
  generic;

  bool get isBrand => this == brand;
  bool get isGeneric => this == generic;
}

class ExploreNamesCubit extends Cubit<ExploreNamesState> {
  final ExploreRepository repo;

  static const int pageSize = 20;

  /// toggle between generic and brand name
  final ExploreNameEnum nameType;

  /// cubit for both generic names and brandnames
  ExploreNamesCubit(this.repo, this.nameType)
    : super(const ExploreNamesState());

  Future getNames() async {
    emit(state.copyWith(status: LoadStatusEnum.loading));
    final Either<ApiError, List<GenericBrandName>> result;
    final pageFilter = PageFilter(
      pageNumber: state.pageNumber,
      pageSize: pageSize,
    );
    if (nameType.isBrand) {
      result = await repo.getBrandNames(pageFilter);
    } else {
      result = await repo.getGenericNames(pageFilter);
    }
    result.fold(
      (left) {
        emit(
          state.copyWith(status: LoadStatusEnum.failed, error: left.message),
        );
      },
      (right) {
        emit(
          state.copyWith(
            brands: right,
            searchResult: right,
            pageNumber: state.pageNumber + 1,
            status: LoadStatusEnum.success,
          ),
        );
      },
    );
  }

  Future nextPage() async {
    int nextPage = state.pageNumber;
    if (state.brands.isNotEmpty) {
      nextPage += 1;
    }
    final Either<ApiError, List<GenericBrandName>> result;
    final pageFilter = PageFilter(pageNumber: nextPage, pageSize: pageSize);
    if (nameType.isBrand) {
      result = await repo.getBrandNames(pageFilter);
    } else {
      result = await repo.getGenericNames(pageFilter);
    }
    result.fold(
      (left) {
        emit(
          state.copyWith(status: LoadStatusEnum.failed, error: left.message),
        );
      },
      (right) {
        emit(
          state.copyWith(
            brands: state.brands..addAll(right),
            searchResult: state.brands..addAll(right),
            pageNumber: nextPage,
            status: LoadStatusEnum.success,
          ),
        );
      },
    );
  }

  void search(String query) {
    emit(
      state.copyWith(
        searchResult:
            state.brands
                .where((subCat) => subCat.name.contains(query))
                .toList(),
      ),
    );
  }
}

class ExploreNamesState extends Equatable {
  final List<GenericBrandName> brands;
  final List<GenericBrandName> searchResult;
  final int pageNumber;
  final LoadStatusEnum status;
  final String? error;

  const ExploreNamesState({
    this.brands = const [],
    this.searchResult = const [],
    this.pageNumber = 0,
    this.status = LoadStatusEnum.initial,
    this.error,
  });

  ExploreNamesState copyWith({
    List<GenericBrandName>? brands,
    List<GenericBrandName>? searchResult,
    int? pageNumber,
    LoadStatusEnum? status,
    String? error,
  }) {
    return ExploreNamesState(
      brands: brands ?? this.brands,
      searchResult: searchResult ?? this.searchResult,
      pageNumber: pageNumber ?? this.pageNumber,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [brands, searchResult, pageNumber, status, error];
}
