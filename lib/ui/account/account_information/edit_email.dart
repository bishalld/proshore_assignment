/*
This is edit email page

include file in reuseable/global_function.dart to call function from GlobalFunction
include file in reuseable/global_widget.dart to call function from GlobalWidget
 */

import 'package:flutter/material.dart';
import 'package:meroshopping_flutter/config/constants.dart';
import 'package:meroshopping_flutter/config/global_style.dart';
import 'package:meroshopping_flutter/ui/account/account_information/edit_email_choose_verification.dart';
import 'package:meroshopping_flutter/ui/reuseable/app_localizations.dart';
import 'package:meroshopping_flutter/ui/reuseable/global_function.dart';
import 'package:meroshopping_flutter/ui/reuseable/global_widget.dart';

class EditEmailPage extends StatefulWidget {
  final String email;
  EditEmailPage({required this.email});
  @override
  _EditEmailPageState createState() => _EditEmailPageState();
}

class _EditEmailPageState extends State<EditEmailPage> {
  // initialize global function and global widget
  final _globalFunction = GlobalFunction();
  final _globalWidget = GlobalWidget();

  TextEditingController _etEmail = TextEditingController();
  bool _buttonDisabled = true;

  @override
  void initState() {
    _etEmail = TextEditingController(text: widget.email);

    if (_globalFunction.validateEmail(_etEmail.text)) {
      _buttonDisabled = false;
    } else {
      _buttonDisabled = true;
    }
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
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: GlobalStyle.appBarIconThemeColor,
          ),
          elevation: GlobalStyle.appBarElevation,
          title: Text(
            AppLocalizations.of(context)!.translate('edit_email')!,
            style: GlobalStyle.appBarTitle,
          ),
          backgroundColor: GlobalStyle.appBarBackgroundColor,
          systemOverlayStyle: GlobalStyle.appBarSystemOverlayStyle,
          bottom: _globalWidget.bottomAppBar(),
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _etEmail,
              style: TextStyle(color: CHARCOAL),
              onChanged: (textValue) {
                setState(() {
                  if (_globalFunction.validateEmail(textValue)) {
                    _buttonDisabled = false;
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
                  labelText: AppLocalizations.of(context)!.translate('email')!,
                  labelStyle: TextStyle(color: BLACK_GREY)),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
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
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.0),
                      )),
                    ),
                    onPressed: () {
                      if (!_buttonDisabled) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditEmailChooseVerificationPage(
                                        email: _etEmail.text)));
                        FocusScope.of(context).unfocus();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        AppLocalizations.of(context)!.translate('next')!,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _buttonDisabled
                                ? Colors.grey[600]
                                : Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ))),
          ],
        ));
  }
}
