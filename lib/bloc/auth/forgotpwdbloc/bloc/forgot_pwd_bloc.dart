import 'package:bloc/bloc.dart';
import 'package:meroshopping_flutter/repositories/auth%20repositories/signinrepository.dart';
import 'package:meta/meta.dart';

part 'forgot_pwd_event.dart';
part 'forgot_pwd_state.dart';

class ForgotPwdBloc extends Bloc<ForgotPwdEvent, ForgotPwdState> {
  ForgotPwdBloc() : super(ForgotPwdInitial()) {
    on<PostEmailEvent>(_onPostEmail);
  }

  void _onPostEmail(PostEmailEvent event, Emitter<ForgotPwdState> emit) async {
    emit(ForgotPwdWaiting());
    try {
      var res = await SignInRepository().forgotPassword(event.email);
      print(res);
      emit(ForgotPwdSuccess(successMsg: res.message));

      // if (res != null) {
      //   print(res);

      // } else
      //   emit(ForgotPwdError(errorMessage: res.message));

    } catch (ex) {
      if (ex != 'cancel') {
        emit(ForgotPwdError(errorMessage: ex.toString()));
      }
    }
  }
}
