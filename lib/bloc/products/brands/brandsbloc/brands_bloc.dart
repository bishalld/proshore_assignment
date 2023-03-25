import 'package:bloc/bloc.dart';
import 'package:meroshopping_flutter/repositories/products/brands/brand_repositories.dart';
import 'package:meta/meta.dart';

part 'brands_event.dart';
part 'brands_state.dart';

class BrandsBloc extends Bloc<BrandsEvent, BrandsState> {
  BrandsBloc() : super(BrandsInitial()) {
    on<BrandsDataEvent>(_brandData);
  }
  void _brandData(BrandsDataEvent event, Emitter<BrandsState> emit) async {
    emit(BrandsWaiting());
    try {
      var res = await BrandRepo().brands();

      emit(BrandsSuccess(data: res.data));
    } catch (ex) {
      if (ex != 'cancel') {
        emit(BrandsError(errorMessage: ex.toString()));
      }
    }
  }
}
