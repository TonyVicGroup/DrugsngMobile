import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/features/explore/data/repository/explore_repository.dart';
import 'package:drugs_ng/features/explore/domain/models/generic_brand_name.dart';
import 'package:drugs_ng/features/explore/domain/models/page_filter.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'explore_names_state.dart';

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
    : super(const ExploreNamesInitial());

  Future getNames() async {
    emit(
      ExploreNamesLoading(state.brands, state.searchResult, state.pageNumber),
    );
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
          ExploreNamesFailed(
            state.brands,
            state.searchResult,
            state.pageNumber,
            left.message,
          ),
        );
      },
      (right) {
        emit(ExploreNamesSuccess(right, right, state.pageNumber));
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
          ExploreNamesFailed(
            state.brands,
            state.searchResult,
            state.pageNumber,
            left.message,
          ),
        );
      },
      (right) {
        emit(
          ExploreNamesSuccess(
            state.brands..addAll(right),
            state.brands..addAll(right),
            nextPage,
          ),
        );
      },
    );
  }

  void search(String query) {
    emit(
      ExploreNamesSuccess(
        state.brands,
        state.brands.where((subCat) => subCat.name.contains(query)).toList(),
        state.pageNumber,
      ),
    );
  }
}
