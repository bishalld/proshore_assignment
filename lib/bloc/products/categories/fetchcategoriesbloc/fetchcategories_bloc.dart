import 'package:bloc/bloc.dart';
import 'package:meroshopping_flutter/repositories/products/categories/categoryrepositories.dart';
import 'package:meta/meta.dart';

part 'fetchcategories_event.dart';
part 'fetchcategories_state.dart';

class FetchcategoriesBloc
    extends Bloc<FetchcategoriesEvent, FetchcategoriesState> {
  FetchcategoriesBloc() : super(FetchcategoriesInitial()) {
    on<FetchAllcategoriesEvent>(_postsignInDataEvent);
  }
  void _postsignInDataEvent(
      FetchAllcategoriesEvent event, Emitter<FetchcategoriesState> emit) async {
    emit(FetchcategoriesWaiting());
    try {
      var res = await CategoryRepository().fetchCategories();

      emit(FetchcategoriesSuccess(data: res.data));
    } catch (ex) {
      if (ex != 'cancel') {
        emit(FetchcategoriesError(errorMessage: ex.toString()));
      }
    }
  }
}
