part of 'checkout_bloc.dart';

@immutable
abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class CheckoutError extends CheckoutState {
  final String errorMessage;

  CheckoutError({
    required this.errorMessage,
  });
}

class CheckoutWaiting extends CheckoutState {}

class CheckoutSuccess extends CheckoutState {
  final int tempId;
  final String message;
  CheckoutSuccess({required this.tempId, required this.message});
}

class getPaymentMethodSuccess extends CheckoutState {}
