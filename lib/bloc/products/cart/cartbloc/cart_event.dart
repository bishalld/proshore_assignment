part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  final int productId;
  final int quantity;
  final int sizeId;
  final int colorId;
  AddToCartEvent(
      {required this.productId,
      required this.quantity,
      required this.sizeId,
      required this.colorId});
}

class GetCartItemsEvent extends CartEvent {}

class UpdateCartItemEvent extends CartEvent {
  final int cartId;
  final int quantity;
  UpdateCartItemEvent({required this.cartId, required this.quantity});
}

class DeleteCartItemEvent extends CartEvent {
  final int cartId;

  DeleteCartItemEvent({required this.cartId});
}
