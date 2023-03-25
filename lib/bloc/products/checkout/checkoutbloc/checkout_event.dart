part of 'checkout_bloc.dart';

@immutable
abstract class CheckoutEvent {}

class PostCheckoutDataEvent extends CheckoutEvent {
  final String city;
  final String state;
  final String comments;
  final String amount;
  final String discount;
  final String deliveryCharge;
  final String totalAmount;
  final dynamic cityArea;
  final String shippingTime;
  PostCheckoutDataEvent(
      {required this.city,
      required this.state,
      required this.comments,
      required this.amount,
      required this.discount,
      required this.deliveryCharge,
      required this.totalAmount,
      required this.cityArea,
      required this.shippingTime});
}

class getPaymentMethodEvent extends CheckoutEvent {
  final String paymentType;
  final String tempId;

  getPaymentMethodEvent({
    required this.paymentType,
    required this.tempId,
  });
}
