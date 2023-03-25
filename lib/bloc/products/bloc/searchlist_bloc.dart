import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../repositories/searchdatarepository/searchlistrepo.dart';

part 'searchlist_event.dart';
part 'searchlist_state.dart';

class SearchlistBloc extends Bloc<SearchlistEvent, SearchlistState> {
  SearchlistBloc() : super(SearchlistInitial()) {
    on<SearchProductEvent>(_getSearchList);
  }

  void _getSearchList(
      SearchProductEvent event, Emitter<SearchlistState> emit) async {
    emit(SearchListWaiting());
    try {
      var res = await SearchRepo().searchList(event.productName);
      emit(SearchListSuccess(searchData: res.data));
      print(res.data);
    } catch (ex) {
      if (ex != 'cancel') {
        emit(SearchListFailed(errorMessage: ex.toString()));
      }
    }
  }
}
