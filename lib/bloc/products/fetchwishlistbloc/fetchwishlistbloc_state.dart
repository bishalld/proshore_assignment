part of 'fetchwishlistbloc_bloc.dart';

@immutable
abstract class FetchwishlistblocState {}

class FetchwishlistblocInitial extends FetchwishlistblocState {}

class FetchWishlistError extends FetchwishlistblocState {
  final String errorMessage;

  FetchWishlistError({required this.errorMessage});
}

class FetchWishListSuccess extends FetchwishlistblocState {
  final List wishData;
  FetchWishListSuccess({required this.wishData});
}

class FetchWishListWaiting extends FetchwishlistblocState {}

//post wish-List

class PostWishListError extends FetchwishlistblocState {
  final String errorMessage;
  PostWishListError({required this.errorMessage});
}

class PostWishListSuccess extends FetchwishlistblocState {
  final String successMessage;
  PostWishListSuccess({required this.successMessage});
}

// delete wishlist
class DeleteWishListError extends FetchwishlistblocState {
  final String errorMessage;
  DeleteWishListError({required this.errorMessage});
}

class DeleteWishListSuccess extends FetchwishlistblocState {
  final String successMessage;
  DeleteWishListSuccess({required this.successMessage});
}
