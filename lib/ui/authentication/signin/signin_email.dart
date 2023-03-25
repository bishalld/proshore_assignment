/*
This is signin with email page

install plugin in pubspec.yaml
- fluttertoast => to show toast (https://pub.dev/packages/fluttertoast)

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meroshopping_flutter/config/constants.dart';
import 'package:meroshopping_flutter/config/global_style.dart';
import 'package:meroshopping_flutter/ui/bottom_navigation_bar.dart';
import 'package:meroshopping_flutter/ui/authentication/forgot_password/forgot_password.dart';
import 'package:meroshopping_flutter/ui/authentication/signup/signup.dart';
import 'package:meroshopping_flutter/ui/reuseable/app_localizations.dart';

class SigninEmailPage extends StatefulWidget {
  final String email;

  const SigninEmailPage({Key? key, this.email = ''}) : super(key: key);

  @override
  _SigninEmailPageState createState() => _SigninEmailPageState();
}

class _SigninEmailPageState extends State<SigninEmailPage> {
  TextEditingController _etEmail = TextEditingController();
  bool _obscureText = true;
  IconData _iconVisible = Icons.visibility_off;

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
      if (_obscureText == true) {
        _iconVisible = Icons.visibility_off;
      } else {
        _iconVisible = Icons.visibility;
      }
    });
  }

  @override
  void initState() {
    _etEmail = TextEditingController(text: widget.email);

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
        Center(child: Image.asset('assets/images/logo_light.png', height: 50)),
        SizedBox(
          height: 80,
        ),
        Text(AppLocalizations.of(context)!.translate('signin')!,
            style: GlobalStyle.authTitle),
        TextFormField(
          enabled: false,
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
            labelStyle: TextStyle(color: BLACK_GREY),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          obscureText: _obscureText,
          style: TextStyle(color: CHARCOAL),
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFCCCCCC)),
            ),
            labelText: AppLocalizations.of(context)!.translate('password')!,
            labelStyle: TextStyle(color: BLACK_GREY),
            suffixIcon: IconButton(
                icon: Icon(_iconVisible, color: Colors.grey[400], size: 20),
                onPressed: () {
                  _toggleObscureText();
                }),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Align(
            alignment: Alignment.centerRight,
            child: Container(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ForgotPasswordPage(email: widget.email)));
                  FocusScope.of(context).unfocus();
                },
                child: Text(
                  AppLocalizations.of(context)!.translate('forgot_password')!,
                  style: TextStyle(color: PRIMARY_COLOR, fontSize: 13),
                ),
              ),
            )),
        SizedBox(
          height: 40,
        ),
        Container(
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
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => BottomNavigationBarPage()),
                    (Route<dynamic> route) => false);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  AppLocalizations.of(context)!.translate('login')!,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              )),
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
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => BottomNavigationBarPage()),
                      (Route<dynamic> route) => false);
                  Fluttertoast.showToast(
                      msg: AppLocalizations.of(context)!
                          .translate('signin_google')!,
                      toastLength: Toast.LENGTH_LONG);
                },
                child: Image(
                  image: AssetImage("assets/images/google.png"),
                  width: 40,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => BottomNavigationBarPage()),
                      (Route<dynamic> route) => false);
                  Fluttertoast.showToast(
                      msg: AppLocalizations.of(context)!
                          .translate('signin_facebook')!,
                      toastLength: Toast.LENGTH_LONG);
                },
                child: Image(
                  image: AssetImage("assets/images/facebook.png"),
                  width: 40,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => BottomNavigationBarPage()),
                      (Route<dynamic> route) => false);
                  Fluttertoast.showToast(
                      msg: AppLocalizations.of(context)!
                          .translate('signin_twitter')!,
                      toastLength: Toast.LENGTH_LONG);
                },
                child: Image(
                  image: AssetImage("assets/images/twitter.png"),
                  width: 40,
                ),
              )
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
                  AppLocalizations.of(context)!.translate('no_account_yet')!,
                  style: GlobalStyle.authBottom1,
                ),
                Text(
                  AppLocalizations.of(context)!.translate('create_one')!,
                  style: GlobalStyle.authBottom2,
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
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
                  ' ' + AppLocalizations.of(context)!.translate('back')!,
                  style: GlobalStyle.back,
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
