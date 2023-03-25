import 'package:bloc/bloc.dart';
import 'package:meroshopping_flutter/repositories/products/categories/categoryrepositories.dart';
part 'getsubcategories_event.dart';
part 'getsubcategories_state.dart';

class GetsubcategoriesBloc
    extends Bloc<GetsubcategoriesEvent, GetsubcategoriesState> {
  GetsubcategoriesBloc() : super(GetsubcategoriesInitial()) {
    on<GetSubcategoriesDataEvent>(_fetchSubcategoriesData);
  }
  void _fetchSubcategoriesData(GetSubcategoriesDataEvent event,
      Emitter<GetsubcategoriesState> emit) async {
    emit(GetsubcategoriesWaiting());
    try {
      var res = await CategoryRepository().getSubCategories(event.id);
      emit(GetsubcategoriesSuccess(data: res.data));
    } catch (ex) {
      if (ex != 'cancel') {
        emit(GetsubcategoriesError(errorMessage: ex.toString()));
      }
    }
  }
}
