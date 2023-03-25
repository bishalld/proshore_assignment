part of 'fetchwishlistbloc_bloc.dart';

@immutable
abstract class FetchwishlistblocEvent {}

class FetchWishListAll extends FetchwishlistblocEvent {}

//post-wishList

class PostWishListEvent extends FetchwishlistblocEvent {
  final int wishlistId;
  PostWishListEvent({required this.wishlistId});
}

//delete wisthlist item

class DeleteWishListEvent extends FetchwishlistblocEvent {
  final int wishlistId;
  DeleteWishListEvent({required this.wishlistId});
}
