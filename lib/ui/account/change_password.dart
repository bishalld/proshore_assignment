/*
This is change password page

include file in reuseable/global_function.dart to call function from GlobalFunction
include file in reuseable/global_widget.dart to call function from GlobalWidget
 */

import 'package:flutter/material.dart';
import 'package:meroshopping_flutter/config/constants.dart';
import 'package:meroshopping_flutter/config/global_style.dart';
import 'package:meroshopping_flutter/ui/reuseable/app_localizations.dart';
import 'package:meroshopping_flutter/ui/reuseable/global_function.dart';
import 'package:meroshopping_flutter/ui/reuseable/global_widget.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  // initialize global function
  final _globalFunction = GlobalFunction();
  final _globalWidget = GlobalWidget();

  final FocusNode _oldPasswordFocus = FocusNode();

  bool _obscureTextNewPass = true;
  bool _obscureTextRetypePass = true;
  IconData _iconVisibleNewPass = Icons.visibility_off;
  IconData _iconVisibleRetypePass = Icons.visibility_off;

  void _toggleNewPass() {
    setState(() {
      _obscureTextNewPass = !_obscureTextNewPass;
      if (_obscureTextNewPass == true) {
        _iconVisibleNewPass = Icons.visibility_off;
      } else {
        _iconVisibleNewPass = Icons.visibility;
      }
    });
  }

  void _toggleRetypePass() {
    setState(() {
      _obscureTextRetypePass = !_obscureTextRetypePass;
      if (_obscureTextRetypePass == true) {
        _iconVisibleRetypePass = Icons.visibility_off;
      } else {
        _iconVisibleRetypePass = Icons.visibility;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _oldPasswordFocus.dispose();
    super.dispose();
  }

  void _showPopupInsertPassword() {
    // set up the buttons
    Widget cancelButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(AppLocalizations.of(context)!.translate('cancel')!,
            style: TextStyle(color: SOFT_BLUE)));
    Widget continueButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
          _globalFunction.startLoading(
              context,
              AppLocalizations.of(context)!
                  .translate('change_password_success')!,
              1);
        },
        child: Text(AppLocalizations.of(context)!.translate('submit')!,
            style: TextStyle(color: SOFT_BLUE)));

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        AppLocalizations.of(context)!.translate('verify')!,
        style: TextStyle(fontSize: 18),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(AppLocalizations.of(context)!.translate('enter_old_password')!,
              style: TextStyle(fontSize: 13, color: BLACK_GREY)),
          TextField(
            obscureText: true,
            focusNode: _oldPasswordFocus,
            style: TextStyle(color: CHARCOAL),
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFCCCCCC)),
              ),
            ),
          ),
        ],
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        FocusScope.of(context).requestFocus(_oldPasswordFocus);
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: GlobalStyle.appBarIconThemeColor,
          ),
          elevation: GlobalStyle.appBarElevation,
          title: Text(
            AppLocalizations.of(context)!.translate('change_password')!,
            style: GlobalStyle.appBarTitle,
          ),
          backgroundColor: GlobalStyle.appBarBackgroundColor,
          systemOverlayStyle: GlobalStyle.appBarSystemOverlayStyle,
          bottom: _globalWidget.bottomAppBar(),
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextField(
              obscureText: _obscureTextNewPass,
              style: TextStyle(color: CHARCOAL),
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                ),
                labelText:
                    AppLocalizations.of(context)!.translate('new_password')!,
                labelStyle: TextStyle(color: BLACK_GREY),
                suffixIcon: IconButton(
                    icon: Icon(_iconVisibleNewPass,
                        color: Colors.grey[400], size: 20),
                    onPressed: () {
                      _toggleNewPass();
                    }),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              obscureText: _obscureTextRetypePass,
              style: TextStyle(color: CHARCOAL),
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                ),
                labelText:
                    AppLocalizations.of(context)!.translate('retype_password')!,
                labelStyle: TextStyle(color: BLACK_GREY),
                suffixIcon: IconButton(
                    icon: Icon(_iconVisibleRetypePass,
                        color: Colors.grey[400], size: 20),
                    onPressed: () {
                      _toggleRetypePass();
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
                    _showPopupInsertPassword();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      AppLocalizations.of(context)!.translate('save')!,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  )),
            ),
          ],
        ));
  }
}
