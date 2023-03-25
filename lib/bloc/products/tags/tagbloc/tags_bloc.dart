import 'package:bloc/bloc.dart';
import 'package:meroshopping_flutter/repositories/products/tag/tagrepository.dart';
import 'package:meta/meta.dart';

part 'tags_event.dart';
part 'tags_state.dart';

class TagsBloc extends Bloc<TagsEvent, TagsState> {
  TagsBloc() : super(TagsInitial()) {
    on<TagDataEvent>(_tagData);
  }
  void _tagData(TagDataEvent event, Emitter<TagsState> emit) async {
    emit(TagsWaiting());
    try {
      var res = await TagRepo().tags();

      emit(TagsSuccess(data: res.data));
    } catch (ex) {
      if (ex != 'cancel') {
        emit(TagsError(errorMessage: ex.toString()));
      }
    }
  }
}
