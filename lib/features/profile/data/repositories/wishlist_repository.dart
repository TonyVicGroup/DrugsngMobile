import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/core/utils/app_data_types.dart';
import 'package:drugs_ng/features/explore/domain/models/page_filter.dart';
import 'package:drugs_ng/features/profile/data/datasources/wishlist_datasource.dart';
import 'package:drugs_ng/features/profile/data/models/wishlist.dart';
import 'package:either_dart/either.dart';

class WishlistRepository {
  final WishlistDatasource datasource = WishlistDatasource();

  AsyncApiErrorOr<List<Wishlist>> getWishlist(PageFilter pageFilter) async {
    try {
      final result = await datasource.getWishlist(pageFilter);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<String> addWishlist(int id, String itemType) async {
    try {
      final result = await datasource.addWishlist(id, itemType);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<String> removeWishlist(int id, String itemType) async {
    try {
      final result = await datasource.removeWishlist(id, itemType);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }
}
