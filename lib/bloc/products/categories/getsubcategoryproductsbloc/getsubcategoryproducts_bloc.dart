import 'package:bloc/bloc.dart';
import 'package:meroshopping_flutter/repositories/products/categories/categoryrepositories.dart';
import 'package:meta/meta.dart';

part 'getsubcategoryproducts_event.dart';
part 'getsubcategoryproducts_state.dart';

class GetsubcategoryproductsBloc
    extends Bloc<GetsubcategoryproductsEvent, GetsubcategoryproductsState> {
  GetsubcategoryproductsBloc() : super(GetsubcategoryproductsInitial()) {
    on<GetsubcategoryproductDataEvent>(_postsignInDataEvent);
  }
  void _postsignInDataEvent(GetsubcategoryproductDataEvent event,
      Emitter<GetsubcategoryproductsState> emit) async {
    emit(GetsubcategoryproductsWaiting());
    try {
      var res = await CategoryRepository().getSubCategoryProducts(event.id);
      emit(GetsubcategoryproductsSuccess(data: res.subCategoryProduct));
    } catch (ex) {
      if (ex != 'cancel') {
        emit(GetsubcategoryproductsError(errorMessage: ex.toString()));
      }
    }
  }
}
