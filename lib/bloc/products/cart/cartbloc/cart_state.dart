part of 'cart_bloc.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartError extends CartState {
  final String errorMessage;

  CartError({
    required this.errorMessage,
  });
}

class CartWaiting extends CartState {}

class AddToCartSuccess extends CartState {
  String message;
  AddToCartSuccess({required this.message});
}

class GetCartItemSuccess extends CartState {
  List data;
  GetCartItemSuccess({required this.data});
}

class UpdateCartSuccess extends CartState {
  // String message;
  // UpdateCartSuccess({required this.message});
}

class DeleteCartSuccess extends CartState {
  // String message;
  // DeleteCartSuccess({required this.message});
}
