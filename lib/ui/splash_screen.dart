/*
This is splash screen page
Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meroshopping_flutter/config/constants.dart';
import 'package:meroshopping_flutter/config/shared_pref.dart';
import 'package:meroshopping_flutter/ui/authentication/signin/signin.dart';
import 'package:meroshopping_flutter/ui/bottom_navigation_bar.dart';
import 'package:meroshopping_flutter/ui/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  Timer? _timer;
  int _second = 3; // set timer for 3 second and then direct to next page

  void _startTimer(StatefulWidget nextPage) {
    const period = const Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      setState(() {
        _second--;
      });
      if (_second == 0) {
        _cancelSplashTimer();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => userToken == "" || userToken == null
                    ? SigninPage()
                    : BottomNavigationBarPage()),
            (Route<dynamic> route) => false);
      }
    });
  }

  void _cancelSplashTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }

  Future<bool> _getOnboarding() async {
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    bool onBoarding = _pref.getBool('onBoarding') ?? true;
    return onBoarding;
  }

  @override
  void initState() {
    HelperClass().getAlluserToken();
    SystemChrome.setSystemUIOverlayStyle(
      Platform.isIOS
          ? SystemUiOverlayStyle.dark
          : SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark),
    );

    StatefulWidget nextPage = OnboardingPage();
    _getOnboarding().then((val) {
      if (val == false) {
        // nextPage = userToken == "" || userToken == null
        //     ? SigninPage()
        //     : BottomNavigationBarPage();
      }

      if (_second != 0) {
        _startTimer(nextPage);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _cancelSplashTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MERO_SHOPPING_ICON_COLOR,
        body: WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: Container(
            child: Center(
              child: Image.asset(
                "assets/icons/mero_shoppinglogo.png",
                height: 500,
              ),
            ),
          ),
        ));
  }
}
