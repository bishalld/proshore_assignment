import 'package:bloc/bloc.dart';
import 'package:meroshopping_flutter/repositories/banner_reop/banner_repository.dart';
import 'package:meta/meta.dart';

part 'homebanner_event.dart';
part 'homebanner_state.dart';

class HomebannerBloc extends Bloc<HomebannerEvent, HomebannerState> {
  HomebannerBloc() : super(BannerInitial()) {
    on<GetBannerEvent>(_getBanner);
  }

  void _getBanner(GetBannerEvent event, Emitter<HomebannerState> emit) async {
    emit(BannerWaiting());

    try {
      //    List<HomeBannerModel> data =
      //     await _apiProvider.getHomeBanner(event.sessionId, event.apiToken);
      // emit(GetHomeBannerSuccess(homeBannerData: data));
      var res = await HomeBannerRepo().fetchBanner();
      emit(BannerSuccess(data: res.data));
    } catch (ex) {
      if (ex != 'cancel') {
        emit(BannerError(errorMessage: ex.toString()));
      }
    }
  }
}
