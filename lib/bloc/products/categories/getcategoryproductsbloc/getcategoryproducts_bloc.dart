import 'package:bloc/bloc.dart';
import 'package:meroshopping_flutter/model/products/categories/get_category_products_response.dart';
import 'package:meroshopping_flutter/repositories/products/categories/categoryrepositories.dart';
import 'package:meta/meta.dart';

part 'getcategoryproducts_event.dart';
part 'getcategoryproducts_state.dart';

class GetcategoryproductsBloc
    extends Bloc<GetcategoryproductsEvent, GetcategoryproductsState> {
  GetcategoryproductsBloc() : super(GetcategoryproductsInitial()) {
    on<GetSubcategoryProductsDataEvent>(_fetchSubcategoryData);
  }
  void _fetchSubcategoryData(GetSubcategoryProductsDataEvent event,
      Emitter<GetcategoryproductsState> emit) async {
    emit(GetcategoryproductsWaiting());
    try {
      var res = await CategoryRepository().getCategoryProducts(event.id);
      emit(GetcategoryproductsSuccess(data: res.categoryProduct.data));
    } catch (ex) {
      if (ex != 'cancel') {
        emit(GetcategoryproductsError(errorMessage: ex.toString()));
      }
    }
  }
}
