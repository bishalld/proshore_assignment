import 'package:bloc/bloc.dart';
import 'package:meroshopping_flutter/repositories/products/tag/tagrepository.dart';
import 'package:meta/meta.dart';

part 'tagproduct_event.dart';
part 'tagproduct_state.dart';

class TagproductBloc extends Bloc<TagproductEvent, TagproductState> {
  TagproductBloc() : super(TagproductInitial()) {
    on<TagproductDataEvent>(_tagProdcuts);
  }
  void _tagProdcuts(
      TagproductDataEvent event, Emitter<TagproductState> emit) async {
    emit(TagproductWaiting());
    try {
      var res = await TagRepo().tagProduct(event.id);

      emit(TagproductSuccess(data: res.tagsProducts));
    } catch (ex) {
      if (ex != 'cancel') {
        emit(TagproductError(errorMessage: ex.toString()));
      }
    }
  }
}
