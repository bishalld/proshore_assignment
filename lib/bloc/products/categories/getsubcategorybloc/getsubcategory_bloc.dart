import 'package:bloc/bloc.dart';
import 'package:meroshopping_flutter/repositories/products/categories/categoryrepositories.dart';
import 'package:meta/meta.dart';

part 'getsubcategory_event.dart';
part 'getsubcategory_state.dart';

class GetsubcategoryBloc
    extends Bloc<GetsubcategoryEvent, GetsubcategoryState> {
  GetsubcategoryBloc() : super(GetsubcategoryInitial()) {
    on<GetSubcategoryDataEvent>(_fetchSubcategoryData);
  }
  void _fetchSubcategoryData(
      GetSubcategoryDataEvent event, Emitter<GetsubcategoryState> emit) async {
    emit(GetSubCategoryWaiting());
    try {
      var res = await CategoryRepository().getSubCategory(event.id);
      emit(GetSubCategorySuccess(data: res.subsubCategory));
    } catch (ex) {
      if (ex != 'cancel') {
        emit(GetSubCategoryError(errorMessage: ex.toString()));
      }
    }
  }
}
