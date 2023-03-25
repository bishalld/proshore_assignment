/*
This is payment page

include file in reuseable/global_widget.dart to call function from GlobalWidget
 */

import 'dart:async';

import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meroshopping_flutter/bloc/products/checkout/checkoutbloc/checkout_bloc.dart';
import 'package:meroshopping_flutter/config/constants.dart';
import 'package:meroshopping_flutter/config/global_style.dart';
import 'package:meroshopping_flutter/ui/bottom_navigation_bar.dart';
import 'package:meroshopping_flutter/ui/reuseable/app_localizations.dart';
import 'package:meroshopping_flutter/ui/reuseable/global_widget.dart';

class PaymentPage extends StatefulWidget {
  final double totalPrice;
  final int tempId;
  PaymentPage({required this.totalPrice, required this.tempId});
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _globalWidget = GlobalWidget();
  String _paymentMethod = '';
  late CheckoutBloc _checkoutBloc;

  @override
  void initState() {
    _checkoutBloc = BlocProvider.of<CheckoutBloc>(context);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  onEsewaPayment() {
    try {
      EsewaFlutterSdk.initPayment(
        esewaConfig: EsewaConfig(
          environment: Environment.test,
          clientId: AppConfig.ESEWA_CLIENT_ID,
          secretId: AppConfig.ESEWA_SECRET_ID,
        ),
        esewaPayment: EsewaPayment(
          productId: DateTime.now().toString(),
          productName: "Test Product",
          productPrice: widget.totalPrice.toString(),
          callbackUrl: "https://www.meroshopping.com",
        ),
        onPaymentSuccess: (data) {
          debugPrint(":::SUCCESS::: => $data");
          print(data.refId);
        },
        onPaymentFailure: (data) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text("Esewa Payment Failure"),
              duration: Duration(seconds: 3),
            ),
          );
        },
        onPaymentCancellation: (data) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text("Esewa Payment Cancelled"),
              duration: Duration(seconds: 3),
            ),
          );
        },
      );
    } on Exception catch (e) {
      debugPrint("EXCEPTION : ${e.toString()}");
    }
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
            AppLocalizations.of(context)!.translate('payment')!,
            style: GlobalStyle.appBarTitle,
          ),
          backgroundColor: GlobalStyle.appBarBackgroundColor,
          systemOverlayStyle: GlobalStyle.appBarSystemOverlayStyle,
          bottom: _globalWidget.bottomAppBar(),
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.translate('summary')!,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                            AppLocalizations.of(context)!
                                .translate('total_payment')!,
                            style: TextStyle(color: CHARCOAL, fontSize: 14)),
                      ),
                      Container(
                        child: Text('${widget.totalPrice.toString()}',
                            style: GlobalStyle.paymentTotalPrice),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 12),
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ChoosepaymentInformation(),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: _paymentMethod == "COD"
                  ? BlocListener<CheckoutBloc, CheckoutState>(
                      listener: (context, state) {
                        if (state is CheckoutError) {
                          Container(
                              child: Center(
                                  child: Text(ERROR_OCCURED,
                                      style: TextStyle(
                                          fontSize: 14, color: BLACK_GREY))));
                        }
                        if (state is getPaymentMethodSuccess) {
                          EasyLoading.showSuccess(
                              "Congratulations! Successfully placed your order");
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BottomNavigationBarPage()),
                            (Route<dynamic> route) => false,
                          );
                        }
                      },
                      child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) => PRIMARY_COLOR,
                            ),
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            )),
                          ),
                          onPressed: () {
                            print(widget.tempId);
                            print(_paymentMethod);
                            _checkoutBloc.add(getPaymentMethodEvent(
                                paymentType: _paymentMethod,
                                tempId: "${widget.tempId}"));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(
                              "Finish",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          )),
                    )
                  : TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) => PRIMARY_COLOR,
                        ),
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        )),
                      ),
                      onPressed: () {
                        onEsewaPayment();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          "Proceed",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      )),
            )
          ],
        ));
  }

  void showLoading(String textMessage) {
    _progressDialog(context);
    Timer(Duration(seconds: 2), () {
      Navigator.pop(context);
      _buildShowDialog(context, textMessage);
    });
  }

  Future _progressDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  Future _buildShowDialog(BuildContext context, String textMessage) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)), //this right here
              child: Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.fromLTRB(40, 20, 40, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      textMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: BLACK_GREY),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) => PRIMARY_COLOR,
                            ),
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            )),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BottomNavigationBarPage()),
                                (Route<dynamic> route) => false);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 16),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .translate('ok')!
                                  .toUpperCase(),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _ChoosepaymentInformation() {
    return Container(
        margin: EdgeInsets.only(top: 12),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(" payment method",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 16,
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return _showPaymentPopup();
                  },
                );
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1, color: Colors.black54),
                    borderRadius: BorderRadius.all(
                        Radius.circular(10) //         <--- border radius here
                        )),
                child: _paymentMethod == ''
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.payment, color: SOFT_BLUE),
                              SizedBox(width: 12),
                              Text("Choose payment method",
                                  style: TextStyle(
                                      color: CHARCOAL,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_paymentMethod,
                                  style: TextStyle(
                                      color: CHARCOAL,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                          //Icon(Icons.chevron_right, size: 20, color: SOFT_GREY),
                        ],
                      ),
              ),
            ),
          ],
        ));
  }

  Widget _showPaymentPopup() {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter mystate) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 12, bottom: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                  color: Colors.grey[500],
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Row(
              children: [
                Icon(Icons.payment, color: SOFT_BLUE),
                SizedBox(width: 8),
                Text("Choose Payment Option:",
                    style: GlobalStyle.chooseCourier),
              ],
            ),
          ),
          Flexible(
            child: ListView(
              padding: EdgeInsets.all(10),
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      _paymentMethod = 'COD';
                    });

                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black54, spreadRadius: 1),
                      ],
                    ),
                    margin: EdgeInsets.only(top: 16),
                    child: Row(
                      children: [
                        Icon(Icons.money, color: SOFT_BLUE),
                        SizedBox(width: 8),
                        Text('Cash On Delivery',
                            style: GlobalStyle.sectionTitle),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      _paymentMethod = 'esewa';
                    });

                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black54, spreadRadius: 1),
                      ],
                    ),
                    margin: EdgeInsets.only(top: 16),
                    child: Row(
                      children: [
                        Image.asset('assets/icons/esewa_icon.png', height: 30),
                        SizedBox(width: 10),
                        Text('Pay Via Esewa', style: GlobalStyle.sectionTitle),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
