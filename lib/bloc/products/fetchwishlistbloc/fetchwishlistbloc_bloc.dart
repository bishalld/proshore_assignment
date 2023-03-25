import 'package:bloc/bloc.dart';
import 'package:meroshopping_flutter/model/wishlistmodel/addedtowishlist.dart';
import 'package:meroshopping_flutter/repositories/wishlistrepository/wishlistrepo.dart';
import 'package:meta/meta.dart';

part 'fetchwishlistbloc_event.dart';
part 'fetchwishlistbloc_state.dart';

class FetchwishlistblocBloc
    extends Bloc<FetchwishlistblocEvent, FetchwishlistblocState> {
  FetchwishlistblocBloc() : super(FetchwishlistblocInitial()) {
    on<FetchWishListAll>(_getWishList);
    on<PostWishListEvent>(postWishList);
    on<DeleteWishListEvent>(deleteWishList);
  }

  void _getWishList(
      FetchWishListAll event, Emitter<FetchwishlistblocState> emit) async {
    emit(FetchWishListWaiting());
    try {
      var res = await WishListRepository().fetchWishList();

      emit(FetchWishListSuccess(wishData: res.wishlist));
    } catch (e) {
      if (e != 'cancel') {
        emit(FetchWishlistError(errorMessage: e.toString()));
      }
    }
  }
  //post wish list bloc

  void postWishList(
      PostWishListEvent event, Emitter<FetchwishlistblocState> emit) async {
    emit(FetchWishListWaiting());
    try {
      var res = await WishListRepository().postWish(event.wishlistId);
      emit(PostWishListSuccess(successMessage: res.message));
    } catch (e) {
      if (e != 'cancel') {
        emit(PostWishListError(errorMessage: e.toString()));
      }
    }
  }

  //delete wishlist item
  void deleteWishList(
      DeleteWishListEvent event, Emitter<FetchwishlistblocState> emit) async {
    emit(FetchWishListWaiting());
    try {
      var res = await WishListRepository().deleteWish(event.wishlistId);
      emit(DeleteWishListSuccess(successMessage: res.message));
    } catch (e) {
      if (e != 'cancel') {
        emit(DeleteWishListError(errorMessage: e.toString()));
      }
    }
  }
}
