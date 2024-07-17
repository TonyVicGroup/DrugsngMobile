import 'package:drugs_ng/src/core/data/models/product_detail.dart';
import 'package:drugs_ng/src/features/explore/presentation/bloc/explore_bloc/explore_bloc.dart';
import 'package:drugs_ng/src/features/explore/presentation/cubit/explore_major_category_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreSearchCubit extends Cubit<List<ProductDetail>> {
  final ExploreBloc exploreBloc;
  ExploreSearchCubit(this.exploreBloc) : super(const []);

  void init() {
    final products = exploreBloc.state.categoryType == MajorCategoryType.drug
        ? exploreBloc.state.drugProducts
        : exploreBloc.state.healthCareProducts;
    emit(products);
  }

  void search(String query) {
    final products = exploreBloc.state.categoryType == MajorCategoryType.drug
        ? exploreBloc.state.drugProducts
        : exploreBloc.state.healthCareProducts;
    List<ProductDetail> searchResult = products
        .where(
          (prod) =>
              prod.name.toLowerCase().contains(query.trim()) ||
              prod.genericName.toLowerCase().contains(query.trim()),
        )
        .toList();
    emit(searchResult);
  }
}
