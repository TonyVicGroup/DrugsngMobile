import 'package:drugs_ng/src/features/explore/presentation/bloc/explore_bloc/explore_bloc.dart';
import 'package:drugs_ng/src/features/product/domain/models/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreSearchCubit extends Cubit<List<Product>> {
  final ExploreBloc exploreBloc;
  ExploreSearchCubit(this.exploreBloc) : super(const []);

  void init() {
    if (exploreBloc.state is ExploreSuccess) {
      final exploreState = exploreBloc.state as ExploreSuccess;
      emit(exploreState.products);
    }
  }

  void search(String query) {
    if (exploreBloc.state is ExploreSuccess) {
      final exploreState = exploreBloc.state as ExploreSuccess;
      List<Product> searchResult = exploreState.products
          .where(
            (prod) =>
                prod.name.toLowerCase().contains(query.trim()) ||
                prod.genericName.toLowerCase().contains(query.trim()),
          )
          .toList();
      emit(searchResult);
    }
  }
}
