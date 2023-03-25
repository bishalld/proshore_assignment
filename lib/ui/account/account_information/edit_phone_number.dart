/*
This is edit phone number page

include file in reuseable/global_function.dart to call function from GlobalFunction
include file in reuseable/global_widget.dart to call function from GlobalWidget
 */

import 'package:flutter/material.dart';
import 'package:meroshopping_flutter/config/constants.dart';
import 'package:meroshopping_flutter/config/global_style.dart';
import 'package:meroshopping_flutter/ui/account/account_information/edit_phone_number_choose_verification.dart';
import 'package:meroshopping_flutter/ui/reuseable/app_localizations.dart';
import 'package:meroshopping_flutter/ui/reuseable/global_function.dart';
import 'package:meroshopping_flutter/ui/reuseable/global_widget.dart';

class EditPhoneNumberPage extends StatefulWidget {
  final String phoneNumber;
  EditPhoneNumberPage({required this.phoneNumber});
  @override
  _EditPhoneNumberPageState createState() => _EditPhoneNumberPageState();
}

class _EditPhoneNumberPageState extends State<EditPhoneNumberPage> {
  // initialize global function and global widget
  final _globalFunction = GlobalFunction();
  final _globalWidget = GlobalWidget();

  TextEditingController _etPhoneNumber = TextEditingController();
  bool _buttonDisabled = true;

  @override
  void initState() {
    _etPhoneNumber = TextEditingController(text: widget.phoneNumber);

    if (_globalFunction.validateMobileNumber(_etPhoneNumber.text)) {
      _buttonDisabled = false;
    } else {
      _buttonDisabled = true;
    }
    super.initState();
  }

  @override
  void dispose() {
    _etPhoneNumber.dispose();
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
            AppLocalizations.of(context)!.translate('edit_phone_number')!,
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
              keyboardType: TextInputType.number,
              controller: _etPhoneNumber,
              style: TextStyle(color: CHARCOAL),
              onChanged: (textValue) {
                setState(() {
                  if (_globalFunction.validateMobileNumber(textValue)) {
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
                  labelText:
                      AppLocalizations.of(context)!.translate('phone_number')!,
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
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
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
                                  EditPhoneNumberChooseVerificationPage(
                                      phoneNumber: _etPhoneNumber.text)));
                      FocusScope.of(context).unfocus();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
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
                  )),
            ),
          ],
        ));
  }
}
