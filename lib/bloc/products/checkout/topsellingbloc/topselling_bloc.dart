import 'package:bloc/bloc.dart';
import 'package:meroshopping_flutter/repositories/products/checkout/check_out_repositories.dart';
import 'package:meta/meta.dart';

part 'topselling_event.dart';
part 'topselling_state.dart';

class TopsellingBloc extends Bloc<TopsellingEvent, TopsellingState> {
  TopsellingBloc() : super(TopsellingInitial()) {
    on<TopsellingDataEvent>(_topSellingProdcuts);
    on<SingleProductDataEvent>(_singleProduct);
  }
  void _topSellingProdcuts(
      TopsellingDataEvent event, Emitter<TopsellingState> emit) async {
    emit(TopsellingWaiting());
    try {
      var res = await CheckOutrepo().topSelingRepo();

      emit(TopsellingSuccess(data: res.data));
    } catch (ex) {
      if (ex != 'cancel') {
        emit(TopsellingError(errorMessage: ex.toString()));
      }
    }
  }

  ///single product function
  void _singleProduct(
      SingleProductDataEvent event, Emitter<TopsellingState> emit) async {
    emit(TopsellingWaiting());
    try {
      var res = await CheckOutrepo().singleProduct(event.urlname);
      //print("this is related: \n ${res.relatedproducts[0].name}");

      emit(SingleProductSuccess(
          singleData: res.data, relatedproducts: res.relatedproducts));
    } catch (ex) {
      if (ex != 'cancel') {
        emit(TopsellingError(errorMessage: ex.toString()));
      }
    }
  }
}
