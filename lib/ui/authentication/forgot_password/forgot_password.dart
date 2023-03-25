/*
This is forgot password page

install plugin in pubspec.yaml
- fluttertoast => to show toast (https://pub.dev/packages/fluttertoast)

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meroshopping_flutter/config/constants.dart';
import 'package:meroshopping_flutter/config/global_style.dart';
import 'package:meroshopping_flutter/ui/reuseable/app_localizations.dart';

import '../../../bloc/auth/forgotpwdbloc/bloc/forgot_pwd_bloc.dart';

class ForgotPasswordPage extends StatefulWidget {
  final String email;

  const ForgotPasswordPage({Key? key, this.email = ''}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController _etEmail = TextEditingController();

  late ForgotPwdBloc _forgotPwdBloc;

  RegExp regex = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _etEmail = TextEditingController(text: widget.email);
    _forgotPwdBloc = BlocProvider.of<ForgotPwdBloc>(context);

    super.initState();
  }

  @override
  void dispose() {
    _etEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.fromLTRB(30, 120, 30, 30),
      children: <Widget>[
        Center(
            child:
                Image.asset('assets/icons/mero_shoppinglogo.png', height: 50)),
        SizedBox(
          height: 80,
        ),
        Form(
          key: _formKey,
          child: TextFormField(
            validator: (value) {
              if (value == null || !regex.hasMatch(value)) {
                return 'Please enter your email address';
              }
              return null;
            },
            enabled: true,
            keyboardType: TextInputType.emailAddress,
            controller: _etEmail,
            style: TextStyle(color: CHARCOAL),
            onChanged: (textValue) {
              setState(() {});
            },
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                ),
                labelText: AppLocalizations.of(context)!.translate('email')!,
                labelStyle: TextStyle(color: BLACK_GREY)),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          AppLocalizations.of(context)!.translate('reset_password_message')!,
          style: GlobalStyle.resetPasswordNotes,
        ),
        SizedBox(
          height: 40,
        ),
        BlocListener<ForgotPwdBloc, ForgotPwdState>(
          listener: ((context, state) {
            if (state is ForgotPwdWaiting) {
              EasyLoading.show(status: "Loading");
            } else if (state is ForgotPwdError) {
              EasyLoading.showError(state.errorMessage);
            } else if (state is ForgotPwdSuccess) {
              Navigator.pop(context);
              EasyLoading.showSuccess(state.successMsg);
            }
          }),
          child: Container(
            child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) => PRIMARY_COLOR,
                  ),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0),
                  )),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _forgotPwdBloc.add(PostEmailEvent(email: _etEmail.text));
                  }

                  FocusScope.of(context).unfocus();

                  // Fluttertoast.showToast(
                  //     msg: AppLocalizations.of(context)!
                  //         .translate('click_reset_password')!,
                  //     toastLength: Toast.LENGTH_LONG);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    AppLocalizations.of(context)!.translate('reset_password')!,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                )),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        // create sign in link
        Center(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GlobalStyle.iconBack,
                Text(
                  AppLocalizations.of(context)!.translate('back_to_login')!,
                  style: GlobalStyle.back,
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
