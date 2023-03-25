import 'package:bloc/bloc.dart';
import 'package:meroshopping_flutter/repositories/auth%20repositories/register_repository.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<PostRegisterDataEvent>(_postRegisterDataEvent);
  }
  void _postRegisterDataEvent(
      PostRegisterDataEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterWaiting());
    try {
      var res = await RegisterRepository().register(event.name, event.email,
          event.password, event.contact, event.address);
      print(res.message);

      if (res.message == "Registered Successfully") {
        print(res.token);
        print(res.message);
        emit(RegisterSuccess(message: res.message, token: res.token));
      } else {
        emit(RegisterError(
            errorMessage: res.message,
            emailErrorMsg: res.errors?.email[0],
            contactErrorMsg: res.errors?.contact[0]));
      }
    } catch (ex) {
      if (ex != 'cancel') {
        //emit(RegisterError(errorMessage: ex.toString()));
      }
    }
  }
}
