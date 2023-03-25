/*
This is add payment method page
We used this pages first when we create new dart file

include file in reuseable/global_function.dart to call function from GlobalFunction
include file in reuseable/global_widget.dart to call function from GlobalWidget

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'package:flutter/material.dart';
import 'package:meroshopping_flutter/config/constants.dart';
import 'package:meroshopping_flutter/config/global_style.dart';
import 'package:meroshopping_flutter/ui/reuseable/app_localizations.dart';
import 'package:meroshopping_flutter/ui/reuseable/global_function.dart';
import 'package:meroshopping_flutter/ui/reuseable/global_widget.dart';

class AddPaymentMethodPage extends StatefulWidget {
  const AddPaymentMethodPage({Key? key}) : super(key: key);

  @override
  _AddPaymentMethodPageState createState() => _AddPaymentMethodPageState();
}

class _AddPaymentMethodPageState extends State<AddPaymentMethodPage> {
  // initialize global function
  final _globalFunction = GlobalFunction();
  final _globalWidget = GlobalWidget();

  List<String> _monthList = [];
  List<String> _yearList = [];
  String? _expiredMonth;
  String? _expiredYear;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _initForLang();
    });

    super.initState();
  }

  void _initForLang() {
    setState(() {
      _expiredMonth = AppLocalizations.of(context)!.translate('month')!;
      _expiredYear = AppLocalizations.of(context)!.translate('year')!;
      // select box data for month of credit card
      _monthList.add(AppLocalizations.of(context)!.translate('month')!);
      _monthList.add("01");
      _monthList.add('02');
      _monthList.add('03');
      _monthList.add('04');
      _monthList.add('05');
      _monthList.add('06');
      _monthList.add('07');
      _monthList.add('08');
      _monthList.add('09');
      _monthList.add('10');
      _monthList.add('11');
      _monthList.add('12');

      // select box data for year of credit card
      _yearList.add(AppLocalizations.of(context)!.translate('year')!);
      _yearList.add("2020");
      _yearList.add('2021');
      _yearList.add('2022');
      _yearList.add('2023');
      _yearList.add('2024');
      _yearList.add('2025');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: GlobalStyle.appBarIconThemeColor,
          ),
          elevation: GlobalStyle.appBarElevation,
          title: Text(
            AppLocalizations.of(context)!.translate('add_payment_method')!,
            style: GlobalStyle.appBarTitle,
          ),
          backgroundColor: GlobalStyle.appBarBackgroundColor,
          systemOverlayStyle: GlobalStyle.appBarSystemOverlayStyle,
          bottom: _globalWidget.bottomAppBar(),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
                AppLocalizations.of(context)!
                    .translate('credit_card_information')!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xffcccccc),
                        width: 1.0,
                      ),
                    ),
                    child: Image.asset('assets/images/visa.png', height: 10),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xffcccccc),
                        width: 1.0,
                      ),
                    ),
                    child:
                        Image.asset('assets/images/mastercard.png', height: 20),
                  ),
                ],
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText: AppLocalizations.of(context)!
                          .translate('credit_card_number')! +
                      ' *',
                  labelStyle: const TextStyle(color: BLACK_GREY)),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText: AppLocalizations.of(context)!
                          .translate('name_of_cardholder')! +
                      ' *',
                  labelStyle: const TextStyle(color: BLACK_GREY)),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
                AppLocalizations.of(context)!.translate('expired_date')! + ' *',
                style: const TextStyle(color: BLACK_GREY, fontSize: 12)),
            Row(
              children: [
                _buildExpiredMonth(),
                const SizedBox(
                  width: 16,
                ),
                _buildExpiredYear(),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
                AppLocalizations.of(context)!.translate('billing_information')!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            TextField(
              decoration: InputDecoration(
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText:
                      AppLocalizations.of(context)!.translate('full_name')! +
                          ' *',
                  labelStyle: const TextStyle(color: BLACK_GREY)),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText:
                      AppLocalizations.of(context)!.translate('company_name')!,
                  labelStyle: TextStyle(color: BLACK_GREY)),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText: AppLocalizations.of(context)!
                          .translate('address_line1')! +
                      ' *',
                  labelStyle: TextStyle(color: BLACK_GREY)),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText:
                      AppLocalizations.of(context)!.translate('address_line2')!,
                  labelStyle: TextStyle(color: BLACK_GREY)),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText:
                      AppLocalizations.of(context)!.translate('city')! + ' *',
                  labelStyle: TextStyle(color: BLACK_GREY)),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText: AppLocalizations.of(context)!
                          .translate('state_province_region')! +
                      ' *',
                  labelStyle: TextStyle(color: BLACK_GREY)),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText:
                      AppLocalizations.of(context)!.translate('postal_code')! +
                          ' *',
                  labelStyle: TextStyle(color: BLACK_GREY)),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                  ),
                  labelText:
                      AppLocalizations.of(context)!.translate('phone_number')! +
                          ' *',
                  labelStyle: TextStyle(color: BLACK_GREY)),
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
                    _globalFunction.startLoading(
                        context,
                        AppLocalizations.of(context)!
                            .translate('add_payment_method_success')!,
                        1);
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

  //  dropdown menu
  DropdownButton<String> _buildExpiredMonth() {
    return DropdownButton<String>(
      value: _expiredMonth,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.grey[700], fontSize: 16),
      underline: Container(
        height: 1,
        color: Colors.grey[600],
      ),
      onChanged: (String? data) {
        setState(() {
          _expiredMonth = data!;
        });
      },
      items: _monthList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Container(
            child: Text(value),
            alignment: Alignment.center,
          ),
        );
      }).toList(),
    );
  }

  DropdownButton<String> _buildExpiredYear() {
    return DropdownButton<String>(
      value: _expiredYear,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.grey[700], fontSize: 16),
      underline: Container(
        height: 1,
        color: Colors.grey[600],
      ),
      onChanged: (String? data) {
        setState(() {
          _expiredYear = data!;
        });
      },
      items: _yearList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Container(
            child: Text(value),
            alignment: Alignment.center,
          ),
        );
      }).toList(),
    );
  }
}
