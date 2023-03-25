/*
This is signup with email page

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meroshopping_flutter/config/constants.dart';
import 'package:meroshopping_flutter/config/global_style.dart';
import 'package:meroshopping_flutter/config/shared_pref.dart';
import 'package:meroshopping_flutter/repositories/auth%20repositories/register_repository.dart';
import 'package:meroshopping_flutter/ui/bottom_navigation_bar.dart';
import 'package:meroshopping_flutter/ui/authentication/signin/signin.dart';
import 'package:meroshopping_flutter/ui/reuseable/app_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignupEmailPage extends StatefulWidget {
  final String email;

  const SignupEmailPage({Key? key, this.email = ''}) : super(key: key);

  @override
  _SignupEmailPageState createState() => _SignupEmailPageState();
}

class _SignupEmailPageState extends State<SignupEmailPage> {
  TextEditingController _etEmail = TextEditingController();
  TextEditingController _etName = TextEditingController();
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
    _etName.dispose();
    super.dispose();
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => SigninPage()),
            (Route<dynamic> route) => false);
        FocusScope.of(context).unfocus();
        return Future.value(true);
      },
      child: ListView(
        padding: EdgeInsets.fromLTRB(30, 120, 30, 30),
        children: <Widget>[
          Center(
              child: Image.asset('assets/images/logo_light.png', height: 50)),
          SizedBox(
            height: 80,
          ),
          Text(AppLocalizations.of(context)!.translate('signup')!,
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
          TextFormField(
            keyboardType: TextInputType.text,
            controller: _etName,
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
              labelText: AppLocalizations.of(context)!.translate('name')!,
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
                    AppLocalizations.of(context)!.translate('register')!,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                )),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => SigninPage()),
                    (Route<dynamic> route) => false);
                FocusScope.of(context).unfocus();
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
          ),
        ],
      ),
    ));
  }

  Future<void> signIn() async {
    try {
      EasyLoading.show(status: "Loading...");
      var response = await _googleSignIn.signIn();
      EasyLoading.dismiss();
      if (response != null) {
        var res = await RegisterRepository().signInGmail(response.displayName,
            response.email, response.id, response.photoUrl);
        if (res != false) {
          HelperClass().setuserToken("token", res.userToken);
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
}
