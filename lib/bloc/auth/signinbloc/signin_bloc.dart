import 'package:bloc/bloc.dart';
import 'package:meroshopping_flutter/repositories/auth%20repositories/signinrepository.dart';
import 'package:meta/meta.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc() : super(SigninInitial()) {
    on<PostsignInDataEvent>(_postsignInDataEvent);
  }
  void _postsignInDataEvent(
      PostsignInDataEvent event, Emitter<SigninState> emit) async {
    emit(SignInWaiting());
    try {
      var res =
          await SignInRepository().signIn(event.phoneNumber, event.password);

      emit(SignInSuccess(message: res.message, token: res.token));
    } catch (ex) {
      if (ex != 'cancel') {
        emit(SigninError(errorMessage: ex.toString()));
      }
    }
  }
}
