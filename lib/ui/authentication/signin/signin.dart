/*
This is signin page

include file in reuseable/global_function.dart to call function from GlobalFunction

install plugin in pubspec.yaml
- fluttertoast => to show toast (https://pub.dev/packages/fluttertoast)

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meroshopping_flutter/bloc/auth/gmailregisterbloc/gmailregister_bloc.dart';
import 'package:meroshopping_flutter/bloc/auth/signinbloc/signin_bloc.dart';
import 'package:meroshopping_flutter/config/constants.dart';
import 'package:meroshopping_flutter/config/global_style.dart';
import 'package:meroshopping_flutter/config/shared_pref.dart';
import 'package:meroshopping_flutter/repositories/auth%20repositories/register_repository.dart';
import 'package:meroshopping_flutter/repositories/auth%20repositories/signinrepository.dart';
import 'package:meroshopping_flutter/ui/authentication/forgot_password/forgot_password.dart';
import 'package:meroshopping_flutter/ui/authentication/signup/signup.dart';
import 'package:meroshopping_flutter/ui/bottom_navigation_bar.dart';
import 'package:meroshopping_flutter/ui/reuseable/app_localizations.dart';
import 'package:meroshopping_flutter/ui/reuseable/global_function.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  // initialize global function
  final _globalFunction = GlobalFunction();
  GoogleSignInAccount? _currentUser;

  bool _buttonDisabled = true;
  String _validate = '';

  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  late SigninBloc _signinBloc;
  late GmailregisterBloc _gmailRegisterBloc;
  bool _passwordVisible = false;

  @override
  void initState() {
    _signinBloc = BlocProvider.of<SigninBloc>(context);

    _googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        _currentUser = account;
      });
    });
    _gmailRegisterBloc = BlocProvider.of<GmailregisterBloc>(context);
    // _googleSignIn.signInSilently();

    super.initState();
  }

  @override
  void dispose() {
    phone.dispose();
    super.dispose();
  }

  // Future<void> signInnn() async {
  //   try {
  //     EasyLoading.show(status: "Loading....");
  //     var response = await _googleSignIn.signIn();
  //     EasyLoading.dismiss();
  //     if (response != null) {
  //       print(response.displayName);
  //       _gmailRegisterBloc.add(PostGmail(
  //         email: response.email,
  //         googleId: response.id,
  //         name: response.displayName ?? "",
  //         service: "app",
  //         avatar: response.photoUrl ?? '',
  //       ));
  //          if (response != false) {
  //         print(response.token);
  //         HelperClass().setuserToken("token", response.userToken);
  //         Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(builder: (context) => BottomNavigationBarPage()),
  //           (route) => false,
  //         );
  //       }
  //     }

  //     print(response);
  //     EasyLoading.dismiss();
  //   } catch (e) {
  //     EasyLoading.showError("$e");
  //     print(e);
  //   }
  // }

  Future<void> signIn() async {
    try {
      EasyLoading.show(status: "Loading...");
      var response = await _googleSignIn.signIn();
      EasyLoading.dismiss();
      if (response != null) {
        var res = await RegisterRepository().signInGmail(response.displayName,
            response.email, response.id, response.photoUrl);
        if (res != false) {
          HelperClass().setuserToken("userToken", res.token);

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BottomNavigationBarPage()),
            (route) => false,
          );
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MERO_SHOPPING_ICON_COLOR,
        body: Container(
          child: _buildedLogin(),
        ));
  }

  Widget _buildedLogin() {
    GoogleSignInAccount? user = _currentUser;

    return ListView(
      padding: EdgeInsets.fromLTRB(30, 120, 30, 30),
      children: <Widget>[
        Center(
          child: Image.asset(
            "assets/icons/mero_shoppinglogo.png",
            height: 200,
          ),
        ),
        SizedBox(
          height: 80,
        ),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: phone,
          style: TextStyle(color: CHARCOAL),
          onChanged: (textValue) {
            setState(() {
              if (_globalFunction.validateMobileNumber(textValue)) {
                _buttonDisabled = false;
                _validate = 'phonenumber';
              } else {
                _buttonDisabled = true;
              }
            });
          },
          decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFCCCCCC)),
              ),
              labelText:
                  AppLocalizations.of(context)!.translate('phone_number')!,
              labelStyle: TextStyle(color: BLACK_GREY)),
        ),
        SizedBox(
          height: 30,
        ),
        TextFormField(
          obscureText: !_passwordVisible,
          keyboardType: TextInputType.emailAddress,
          controller: password,
          style: TextStyle(color: CHARCOAL),

          // onChanged: (textValue) {
          //   setState(() {
          //     if (_globalFunction.validateMobileNumber(textValue)) {
          //       _buttonDisabled = false;
          //       _validate = 'phonenumber';
          //     } else if (_globalFunction.validateEmail(textValue)) {
          //       _buttonDisabled = false;
          //       _validate = 'email';
          //     } else {
          //       _buttonDisabled = true;
          //     }
          //   });
          // },
          decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black54,
                  size: 20,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFCCCCCC)),
              ),
              labelText: "Password",
              labelStyle: TextStyle(color: BLACK_GREY)),
        ),
        TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ForgotPasswordPage()));
            },
            child: Text(
              "Forgot Password ?",
              style: TextStyle(color: BLACK_GREY, fontSize: 12),
            )),
        SizedBox(
          height: 30,
        ),
        BlocConsumer<SigninBloc, SigninState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is SignInWaiting) {
              EasyLoading.show(status: "Loading...");
            } else if (state is SigninError) {
              EasyLoading.showError("Phone number or password is incorrect");
              // Fluttertoast.showToast(
              //     msg: state.errorMessage,
              //     toastLength: Toast.LENGTH_SHORT,
              //     gravity: ToastGravity.BOTTOM,
              //     timeInSecForIosWeb: 1,4
              //     backgroundColor: Colors.red,
              //     textColor: Colors.white,
              //     fontSize: 16.0);
            } else if (state is SignInSuccess) {
              print(state.token);
              HelperClass().setuserToken("userToken", state.token);

              EasyLoading.showSuccess("You have successfully signed in");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BottomNavigationBarPage()));
            }
          },
          builder: (context, state) {
            return Container(
              child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) =>
                          states.contains(MaterialState.disabled)
                              ? Colors.grey[300]!
                              : _buttonDisabled
                                  ? Colors.grey[300]!
                                  : PRIMARY_COLOR,
                    ),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                  ),
                  onPressed: () {
                    if (!_buttonDisabled) {
                      if (_validate == 'phonenumber') {
                        _signinBloc.add(
                          PostsignInDataEvent(
                              phoneNumber: phone.text, password: password.text),
                        );

                        FocusScope.of(context).unfocus();
                      }
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      AppLocalizations.of(context)!.translate('signin')!,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _buttonDisabled
                              ? Colors.grey[600]
                              : Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  )),
            );
          },
        ),
        SizedBox(
          height: 40,
        ),
        Center(
          child: Text(
            AppLocalizations.of(context)!.translate('or_signin_with')!,
            style: GlobalStyle.authSignWith,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  signIn();
                },
                child: Image(
                  image: AssetImage("assets/images/google.png"),
                  width: 40,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignupPage()));
              FocusScope.of(context).unfocus();
            },
            child: Wrap(
              children: [
                Text(
                  "Don't you an account? ",
                  style: GlobalStyle.authBottom1,
                ),
                Text(
                  "Register a new account",
                  style: GlobalStyle.authBottom2,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
