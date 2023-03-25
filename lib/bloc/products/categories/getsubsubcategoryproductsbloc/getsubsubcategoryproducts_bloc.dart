import 'package:bloc/bloc.dart';
import 'package:meroshopping_flutter/repositories/products/categories/categoryrepositories.dart';
import 'package:meta/meta.dart';

part 'getsubsubcategoryproducts_event.dart';
part 'getsubsubcategoryproducts_state.dart';

class GetsubsubcategoryproductsBloc extends Bloc<GetsubsubcategoryproductsEvent,
    GetsubsubcategoryproductsState> {
  GetsubsubcategoryproductsBloc() : super(GetsubsubcategoryproductsInitial()) {
    on<GetSubcategoryProductsDataEvent>(_fetchSubSubcategoryProductsData);
  }
  void _fetchSubSubcategoryProductsData(GetSubcategoryProductsDataEvent event,
      Emitter<GetsubsubcategoryproductsState> emit) async {
    emit(GetsubsubcategoryproductsWaiting());
    try {
      var res = await CategoryRepository().getSubSubCategoryProducts(event.id);
      emit(GetsubsubcategoryproductsSuccess(data: res.subsubCategoryProduct));
    } catch (ex) {
      if (ex != 'cancel') {
        emit(GetsubsubcategoryproductsError(errorMessage: ex.toString()));
      }
    }
  }
}
