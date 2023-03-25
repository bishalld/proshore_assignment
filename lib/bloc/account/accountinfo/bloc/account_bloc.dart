import 'package:bloc/bloc.dart';
import 'package:meroshopping_flutter/repositories/accountinforepo/accountinforepo.dart';
import 'package:meta/meta.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial()) {
    on<AccountInfoEvent>(_getUserInfo);
  }

  void _getUserInfo(AccountInfoEvent event, Emitter<AccountState> emit) async {
    emit(AccountFetcWaiting());
    try {
      var res = await AccountRepository().fetchAccountInfo();

      emit(AccountFetchSuccessState(accountData: res.data));
    } catch (e) {
      if (e != 'cancel') {
        emit(AccountFetchErrorState(errorMessage: e.toString()));
      }
    }
  }

  // void updateProfile(
  //     AccountUpdateEvent event, Emitter<AccountState> emit) async {
  //   emit(AccountFetcWaiting());
  //   try {
  //     var res = await UpdateProfile().profileUpdate(
  //         event.name, event.email, event.contact, event.imageUrl, context);
  //   } catch (e) {
  //     emit(AccountFetchErrorState(errorMessage: e.toString()));
  //   }
  // }
}
