import 'package:drugs_ng/core/enum/item_type_enum.dart';
import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:drugs_ng/features/explore/domain/models/page_filter.dart';
import 'package:drugs_ng/features/profile/data/models/wishlist.dart';
import 'package:drugs_ng/features/profile/data/repositories/wishlist_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final WishlistRepository repo = WishlistRepository();

  static const int pageSize = 20;

  WishlistCubit() : super(WishlistState.initial());

  Future getWishlist() async {
    emit(state.copy(status: LoadStatusEnum.loading, addRemoveId: -2));
    final result = await repo.getWishlist(
      PageFilter(pageNumber: state.pageNumber, pageSize: pageSize),
    );
    result.fold((left) => emit(state.copy(status: LoadStatusEnum.failed)), (
      right,
    ) {
      final wishlistIds =
          right.map((e) => WishlistId(e.itemId, e.itemType)).toSet();
      emit(
        state.copy(
          wishlist: right,
          status: LoadStatusEnum.success,
          wishlistIds: wishlistIds,
        ),
      );
    });
  }

  Future nextWishlistPage() async {
    final result = await repo.getWishlist(
      PageFilter(pageNumber: state.pageNumber, pageSize: pageSize),
    );
    result.fold(
      (left) {
        emit(state.copy(status: LoadStatusEnum.failed));
      },
      (right) {
        final allWishlist = [...state.wishlist, ...right];
        final wishlistIds =
            allWishlist.map((e) => WishlistId(e.itemId, e.itemType)).toSet();
        emit(
          state.copy(
            wishlist: allWishlist,
            status: LoadStatusEnum.success,
            pageNumber: state.pageNumber + 1,
            wishlistIds: wishlistIds,
          ),
        );
      },
    );
  }

  Future<void> addWishlist(int id, ItemTypeEnum type) async {
    emit(state.copy(addRemoveStatus: LoadStatusEnum.loading, addRemoveId: id));
    final result = await repo.addWishlist(id, type.id);
    if (result.isLeft) {
      final isWishlistEmpy = state.wishlist.isEmpty;
      emit(
        state.copy(
          addRemoveStatus: LoadStatusEnum.failed,
          message: result.left.message,
        ),
      );
      if (isWishlistEmpy) {
        // if the wishlist was empty before,
        // fetch the wishlist again to show previously added items
        await getWishlist();
      }
    } else {
      Set<WishlistId> updatedIds = Set.from(state.wishlistIds)
        ..add(WishlistId(id, type));
      emit(
        state.copy(
          wishlistIds: updatedIds,
          addRemoveStatus: LoadStatusEnum.success,
          message: result.right,
        ),
      );
      await getWishlist();
    }
  }

  Future<void> removeWishlist(int id, ItemTypeEnum type) async {
    emit(state.copy(addRemoveStatus: LoadStatusEnum.loading, addRemoveId: id));
    final result = await repo.removeWishlist(id, type.id);
    if (result.isLeft) {
      emit(
        state.copy(
          addRemoveStatus: LoadStatusEnum.failed,
          message: result.left.message,
        ),
      );
      final isWishlistEmpy = state.wishlist.isEmpty;
      if (isWishlistEmpy) {
        // if the wishlist was empty before,
        // fetch the wishlist again to show previously added items
        await getWishlist();
      }
    } else {
      Set<WishlistId> updatedIds = Set.from(state.wishlistIds)
        ..remove(WishlistId(id, type));
      final updatedWishlist =
          state.wishlist
              .where(
                (element) =>
                    !(element.itemId == id && element.itemType == type),
              )
              .toList();
      emit(
        state.copy(
          wishlist: updatedWishlist,
          wishlistIds: updatedIds,
          addRemoveStatus: LoadStatusEnum.success,
          message: result.right,
        ),
      );
      await getWishlist();
    }
  }

  Future<void> addWishlistToCart() async {
    for (var item in state.wishlist) {
      await removeWishlist(item.itemId, item.itemType);
    }
  }

  void resetData() {
    emit(WishlistState.initial());
  }
}
