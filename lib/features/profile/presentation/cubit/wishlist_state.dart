part of 'wishlist_cubit.dart';

class WishlistState extends Equatable {
  final List<Wishlist> wishlist;
  final int pageNumber;
  final LoadStatusEnum status;
  // manage ui for adding and removing from wishlist
  final LoadStatusEnum addRemoveStatus;
  final int addRemoveId;
  // set of ids being added or removed
  final Set<WishlistId> wishlistIds;
  //
  final String? message;

  const WishlistState({
    required this.wishlist,
    required this.pageNumber,
    required this.status,
    required this.addRemoveStatus,
    required this.addRemoveId,
    required this.wishlistIds,
    this.message,
  });

  factory WishlistState.initial() => const WishlistState(
    wishlist: [],
    pageNumber: 0,
    status: LoadStatusEnum.initial,
    addRemoveStatus: LoadStatusEnum.initial,
    addRemoveId: -1,
    wishlistIds: {},
  );

  bool isInWishlist(int id, ItemTypeEnum itemType) =>
      wishlistIds.contains(WishlistId(id, itemType));

  WishlistState copy({
    List<Wishlist>? wishlist,
    int? pageNumber,
    LoadStatusEnum? status,
    LoadStatusEnum? addRemoveStatus,
    int? addRemoveId,
    Set<WishlistId>? wishlistIds,
    String? message,
  }) => WishlistState(
    wishlist: wishlist ?? this.wishlist,
    pageNumber: pageNumber ?? this.pageNumber,
    status: status ?? this.status,
    addRemoveStatus: addRemoveStatus ?? this.addRemoveStatus,
    addRemoveId: addRemoveId ?? this.addRemoveId,
    wishlistIds: wishlistIds ?? this.wishlistIds,
    message: message ?? this.message,
  );

  @override
  List<Object?> get props => [
    wishlist,
    pageNumber,
    status,
    addRemoveStatus,
    addRemoveId,
    wishlistIds,
    message,
  ];
}

class WishlistId extends Equatable {
  final int id;
  final ItemTypeEnum itemType;

  const WishlistId(this.id, this.itemType);

  @override
  List<Object?> get props => [id, itemType];
}
