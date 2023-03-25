import 'package:bloc/bloc.dart';
import 'package:meroshopping_flutter/repositories/products/checkout/check_out_repositories.dart';
import 'package:meta/meta.dart';
part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(CheckoutInitial()) {
    on<PostCheckoutDataEvent>(_checkout);
    on<getPaymentMethodEvent>(_getPaymentMethod);
  }
  void _checkout(
      PostCheckoutDataEvent event, Emitter<CheckoutState> emit) async {
    emit(CheckoutWaiting());
    try {
      var res = await CheckOutrepo().checkOut(
          event.city,
          event.state,
          event.comments,
          event.amount,
          event.discount,
          event.deliveryCharge,
          event.totalAmount,
          event.cityArea,
          event.shippingTime,
          "app");

      emit(CheckoutSuccess(tempId: res.tempId, message: res.message));
    } catch (ex) {
      if (ex != 'cancel') {
        emit(CheckoutError(errorMessage: ex.toString()));
      }
    }
  }

  void _getPaymentMethod(
      getPaymentMethodEvent event, Emitter<CheckoutState> emit) async {
    emit(CheckoutWaiting());
    try {
      var res = await CheckOutrepo()
          .getPaymentMethod(event.paymentType, event.tempId);

      emit(getPaymentMethodSuccess());
    } catch (ex) {
      if (ex != 'cancel') {
        emit(CheckoutError(errorMessage: ex.toString()));
      }
    }
  }
}
