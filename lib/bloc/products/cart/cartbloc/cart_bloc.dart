import 'package:bloc/bloc.dart';
import 'package:meroshopping_flutter/repositories/products/cart/cart_repositories.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<AddToCartEvent>(_addToCart);
    on<GetCartItemsEvent>(_getCartitem);
    on<UpdateCartItemEvent>(_updatecartItem);
    on<DeleteCartItemEvent>(_deletecartItem);
  }

  //add to cart function
  void _addToCart(AddToCartEvent event, Emitter<CartState> emit) async {
    emit(CartWaiting());
    try {
      var res = await CartRepository().addToCart(
          event.productId, event.quantity, event.sizeId, event.colorId);
      print(res.message);

      emit(AddToCartSuccess(message: res.message));
    } catch (ex) {
      if (ex != 'cancel') {
        emit(CartError(errorMessage: ex.toString()));
      }
    }
  }

  ///get cart items function
  void _getCartitem(GetCartItemsEvent event, Emitter<CartState> emit) async {
    emit(CartWaiting());
    try {
      var res = await CartRepository().getcartItem();

      emit(GetCartItemSuccess(data: res.cartItems));
    } catch (ex) {
      if (ex != 'cancel') {
        emit(CartError(errorMessage: ex.toString()));
      }
    }
  }

  ///update cart items function
  void _updatecartItem(
      UpdateCartItemEvent event, Emitter<CartState> emit) async {
    emit(CartWaiting());
    try {
      var res =
          await CartRepository().updateCartItem(event.cartId, event.quantity);

      emit(UpdateCartSuccess());
    } catch (ex) {
      if (ex != 'cancel') {
        emit(CartError(errorMessage: ex.toString()));
      }
    }
  }

  ///delete cart items function
  void _deletecartItem(
      DeleteCartItemEvent event, Emitter<CartState> emit) async {
    emit(CartWaiting());
    try {
      var res = await CartRepository().deleteCartItem(event.cartId);

      emit(DeleteCartSuccess());
    } catch (ex) {
      if (ex != 'cancel') {
        emit(CartError(errorMessage: ex.toString()));
      }
    }
  }
}
