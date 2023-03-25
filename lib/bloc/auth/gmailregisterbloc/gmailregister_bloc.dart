import 'package:bloc/bloc.dart';
import 'package:meroshopping_flutter/repositories/auth%20repositories/register_repository.dart';
import 'package:meta/meta.dart';

part 'gmailregister_event.dart';
part 'gmailregister_state.dart';

class GmailregisterBloc extends Bloc<GmailregisterEvent, GmailregisterState> {
  GmailregisterBloc() : super(GmailregisterInitial()) {
    on<PostGmail>(_postGmailDataEvent);
  }
  void _postGmailDataEvent(
      PostGmail event, Emitter<GmailregisterState> emit) async {
    emit(GmailRegisterWaiting());
    try {
      var res = await RegisterRepository()
          .signInGmail(event.googleId, event.avatar, event.name, event.email);
      emit(GmailRegisterSuccess(
          message: res.message,
          token: res.token,
          status: res.status,
          fileName: res.filename,
          success: res.success));
      // if (res.intToken == 0) {
      // } else if (res.intToken == 1) {
      //   print(res.errors.email[0]);
      //   emit(GmailRegisterError(errorMessage: res.message));
      // }
    } catch (e) {
      print(e);
    }
  }
}
