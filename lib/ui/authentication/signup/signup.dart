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
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meroshopping_flutter/bloc/auth/registerbloc/register_bloc.dart';
import 'package:meroshopping_flutter/config/constants.dart';
import 'package:meroshopping_flutter/config/global_style.dart';
import 'package:meroshopping_flutter/config/shared_pref.dart';
import 'package:meroshopping_flutter/ui/authentication/signin/signin.dart';
import 'package:meroshopping_flutter/ui/bottom_navigation_bar.dart';
import 'package:meroshopping_flutter/ui/reuseable/app_localizations.dart';
import 'package:meroshopping_flutter/ui/reuseable/global_function.dart';

import '../../../repositories/auth repositories/register_repository.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // initialize global function
  final _globalFunction = GlobalFunction();

  bool _buttonDisabled = true;
  String _validate = '';
  late RegisterBloc _registerBloc;
  final _formKey = GlobalKey<FormState>();
  RegExp regex = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  RegExp regExp = new RegExp(r'(^(?:[+0]9)?[0-9]{10,15}$)');
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  GoogleSignInAccount? currentgmailUser;
  bool _passwordVisible = false;
  @override
  void initState() {
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        currentgmailUser = account;
      });
    });
    super.initState();
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MERO_SHOPPING_ICON_COLOR,
        body:
            //  BlocBuilder<RegisterBloc, RegisterState>(
            //   builder: (context, state) {
            //   return
            Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.fromLTRB(30, 120, 30, 30),
            children: <Widget>[
              Center(
                child: Image.asset("assets/icons/mero_shoppinglogo.png"),
              ),
              SizedBox(
                height: 80,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                controller: name,
                style: TextStyle(color: CHARCOAL),
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                    ),
                    labelText: "Name",
                    labelStyle: TextStyle(color: BLACK_GREY)),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || !regex.hasMatch(value)) {
                    return 'Please enter your email address';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                controller: email,
                style: TextStyle(color: CHARCOAL),
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                    ),
                    labelText: "Email",
                    labelStyle: TextStyle(color: BLACK_GREY)),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                obscureText: !_passwordVisible,
                keyboardType: TextInputType.emailAddress,
                controller: password,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                style: TextStyle(color: CHARCOAL),
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
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
                        borderSide:
                            BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                    ),
                    labelText: "Password",
                    labelStyle: TextStyle(color: BLACK_GREY)),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: phone,
                validator: (value) {
                  if (value == null ||
                      !regExp.hasMatch(value) ||
                      value.length < 10 ||
                      value.length > 10) {
                    return 'Please enter your number';
                  }
                  return null;
                },
                style: TextStyle(color: CHARCOAL),
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                    ),
                    labelText: "Contact Number",
                    labelStyle: TextStyle(color: BLACK_GREY)),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: address,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
                style: TextStyle(color: CHARCOAL),
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                    ),
                    labelText: "Address",
                    labelStyle: TextStyle(color: BLACK_GREY)),
              ),
              SizedBox(
                height: 30,
              ),
              BlocListener<RegisterBloc, RegisterState>(
                listener: ((context, state) {
                  if (state is RegisterWaiting) {
                    EasyLoading.show(status: "Loading");
                  } else if (state is RegisterError) {
                    EasyLoading.showError("Error Occured");
                  } else if (state is RegisterSuccess) {
                    HelperClass().setuserToken("userToken", state.token);
                    // print("this is in signup page ${state.message}");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomNavigationBarPage()));
                    EasyLoading.showSuccess("You have successfully registered");
                    {}
                  }
                }),
                child: Container(
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(PRIMARY_COLOR),
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                    ),
                    onPressed: () {
                      print("pressed");
                      if (_formKey.currentState!.validate()) {
                        _registerBloc.add(
                          PostRegisterDataEvent(
                            name: name.text,
                            email: email.text,
                            password: password.text,
                            contact: phone.text,
                            address: address.text,
                          ),
                        );

                        FocusScope.of(context).unfocus();
                      } else {
                        EasyLoading.showError("Please enter valid email");
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        AppLocalizations.of(context)!.translate('register')!,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _buttonDisabled
                                ? Colors.grey[600]
                                : Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),

              // BlocListener<RegisterBloc, RegisterState>(
              //   listener: ((context, state) {
              //     if (state is RegisterWaiting) {
              //       EasyLoading.show(status: "Loading");
              //     } else if (state is RegisterError) {
              //       print(state.emailErrorMsg);
              //       EasyLoading.showError(state.emailErrorMsg);
              //     } else if (state is RegisterSuccess) {
              //       HelperClass().setuserToken("userToken", state.token);
              //       print(state.message);
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => BottomNavigationBarPage()));
              //       EasyLoading.showSuccess("You have successfully registered");
              //     }
              //     EasyLoading.dismiss();
              //   }),
              //   child: Container(
              //     child: TextButton(
              //         style: ButtonStyle(
              //           backgroundColor:
              //               MaterialStateProperty.all(PRIMARY_COLOR),

              //           overlayColor:
              //               MaterialStateProperty.all(Colors.transparent),
              //           shape: MaterialStateProperty.all(RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(10.0),
              //           )),
              //         ),
              //         onPressed: () {
              //           print("pressed");
              //           if (_formKey.currentState!.validate()) {
              //             _registerBloc.add(
              //               PostRegisterDataEvent(
              //                 name: name.text,
              //                 email: email.text,
              //                 password: password.text,
              //                 contact: phone.text,
              //                 address: address.text,
              //               ),
              //             );

              //             FocusScope.of(context).unfocus();
              //           }

              //         },
              //         child: Padding(
              //           padding: const EdgeInsets.symmetric(vertical: 5.0),
              //           child: Text(
              //             AppLocalizations.of(context)!.translate('register')!,
              //             style: TextStyle(
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.bold,
              //                 color: _buttonDisabled
              //                     ? Colors.grey[600]
              //                     : Colors.white),
              //             textAlign: TextAlign.center,
              //           ),
              //         ),
              //         ),
              //   ),
              // ),
              SizedBox(
                height: 40,
              ),
              Center(
                child: Text(
                  AppLocalizations.of(context)!.translate('or_signup_with')!,
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
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             BottomNavigationBarPage()));
                        // Fluttertoast.showToast(
                        //     msg: AppLocalizations.of(context)!
                        //         .translate('signin_google')!,
                        //     toastLength: Toast.LENGTH_LONG);
                      },
                      child: Image(
                        image: AssetImage("assets/images/google.png"),
                        width: 40,
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.pushReplacement(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) =>
                    //                 BottomNavigationBarPage()));
                    //     Fluttertoast.showToast(
                    //         msg: AppLocalizations.of(context)!
                    //             .translate('signin_facebook')!,
                    //         toastLength: Toast.LENGTH_LONG);
                    //   },
                    //   child: Image(
                    //     image: AssetImage("assets/images/facebook.png"),
                    //     width: 40,
                    //   ),
                    // ),

                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.pushReplacement(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => BottomNavigationBarPage()));
                    //     Fluttertoast.showToast(
                    //         msg: AppLocalizations.of(context)!
                    //             .translate('signin_twitter')!,
                    //         toastLength: Toast.LENGTH_LONG);
                    //   },
                    //   child: Image(
                    //     image: AssetImage("assets/images/twitter.png"),
                    //     width: 40,
                    //   ),
                    // )
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
                        MaterialPageRoute(builder: (context) => SigninPage()));
                    FocusScope.of(context).unfocus();
                  },
                  child: Wrap(
                    children: [
                      Text(
                        "Already have an account? ",
                        style: GlobalStyle.authBottom1,
                      ),
                      Text(
                        "Sign In Here",
                        style: GlobalStyle.authBottom2,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
        //   },
        // )
        );
  }

  Future<void> signIn() async {
    try {
      EasyLoading.show(status: "Loading...");
      var response = await _googleSignIn.signIn();

      if (response != null) {
        EasyLoading.dismiss();

        var res = await RegisterRepository().signInGmail(response.displayName,
            response.email, response.id, response.photoUrl);
        if (res != false) {
          HelperClass().setuserToken("userToken", res.token);
          print(res.token);
        }
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigationBarPage()),
          (route) => false,
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
