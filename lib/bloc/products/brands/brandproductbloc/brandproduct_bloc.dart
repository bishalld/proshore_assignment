import 'package:bloc/bloc.dart';
import 'package:meroshopping_flutter/repositories/products/brands/brand_repositories.dart';
import 'package:meta/meta.dart';

part 'brandproduct_event.dart';
part 'brandproduct_state.dart';

class BrandproductBloc extends Bloc<BrandproductEvent, BrandproductState> {
  BrandproductBloc() : super(BrandproductInitial()) {
    on<BrandProductDataEvent>(_brandData);
  }
  void _brandData(
      BrandProductDataEvent event, Emitter<BrandproductState> emit) async {
    emit(BrandproductWaiting());
    try {
      var res = await BrandRepo().brandProduct(event.id);

      emit(BrandProductSuccess(data: res.brandProduct));
    } catch (ex) {
      if (ex != 'cancel') {
        emit(BrandproductError(errorMessage: ex.toString()));
      }
    }
  }
}
