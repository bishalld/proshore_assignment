/*
This is notification page

include file in reuseable/global_widget.dart to call function from GlobalWidget
include file in reuseable/shimmer_loading.dart to use shimmer loading
Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meroshopping_flutter/config/constants.dart';
import 'package:meroshopping_flutter/config/global_style.dart';
import 'package:meroshopping_flutter/ui/account/order/order_status.dart';
import 'package:meroshopping_flutter/ui/home/topsale.dart';
import 'package:meroshopping_flutter/ui/reuseable/app_localizations.dart';
import 'package:meroshopping_flutter/ui/reuseable/global_widget.dart';
import 'package:meroshopping_flutter/ui/reuseable/shimmer_loading.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  // initialize global widget and shimmer loading
  final _globalWidget = GlobalWidget();
  final _shimmerLoading = ShimmerLoading();

  bool _loading = true;
  Timer? _timerLoadingDummy;

  @override
  void initState() {
    // this timer function is just for demo, so after 2 second, the shimmer loading will disappear and show the content
    _timerLoadingDummy = Timer(Duration(milliseconds: 200), () {
      setState(() {
        _loading = false;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _timerLoadingDummy?.cancel();

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
            'Notification',
            style: GlobalStyle.appBarTitle,
          ),
          backgroundColor: GlobalStyle.appBarBackgroundColor,
          systemOverlayStyle: GlobalStyle.appBarSystemOverlayStyle,
          bottom: _globalWidget.bottomAppBar(),
        ),
        body: WillPopScope(
          onWillPop: () {
            Navigator.pop(context);
            return Future.value(true);
          },
          child: Container(
              child: (_loading == true)
                  ? _shimmerLoading.buildShimmerContent()
                  : ListView(children: <Widget>[
                      _createItem(
                          notifDate: '11 Sep 2019 08:40',
                          notifTitle: AppLocalizations.of(context)!
                              .translate('order_completed')!,
                          notifMessage: AppLocalizations.of(context)!
                              .translate('order_completed_message')!,
                          page: OrderStatusPage()),
                      _createItem(
                          notifDate: '11 Sep 2019 08:39',
                          notifTitle: AppLocalizations.of(context)!
                              .translate('order_arrived')!,
                          notifMessage: AppLocalizations.of(context)!
                              .translate('order_arrived_message')!,
                          page: OrderStatusPage()),
                      _createItem(
                          notifDate: '10 Sep 2019 10:00',
                          notifTitle: AppLocalizations.of(context)!
                              .translate('flash_sale')!,
                          notifMessage: AppLocalizations.of(context)!
                              .translate('flash_sale_notif')!,
                          page: topSellingPage()),
                      _createItem(
                          notifDate: '9 Sep 2019 14:12',
                          notifTitle: AppLocalizations.of(context)!
                              .translate('order_sent')!,
                          notifMessage: AppLocalizations.of(context)!
                              .translate('order_sent_message')!,
                          page: OrderStatusPage()),
                      _createItem(
                          notifDate: '9 Sep 2019 14:12',
                          notifTitle: AppLocalizations.of(context)!
                              .translate('ready_to_pickup')!,
                          notifMessage: AppLocalizations.of(context)!
                              .translate('ready_to_pickup_message')!,
                          page: OrderStatusPage()),
                      _createItem(
                          notifDate: '9 Sep 2019 13:00',
                          notifTitle: AppLocalizations.of(context)!
                              .translate('trending_product')!,
                          notifMessage: AppLocalizations.of(context)!
                              .translate('trending_product_notif')!),
                      _createItem(
                          notifDate: '9 Sep 2019 12:12',
                          notifTitle: AppLocalizations.of(context)!
                              .translate('order_processed')!,
                          notifMessage: AppLocalizations.of(context)!
                              .translate('order_processed_message')!,
                          page: OrderStatusPage()),
                      _createItem(
                          notifDate: '9 Sep 2019 11:52',
                          notifTitle: AppLocalizations.of(context)!
                              .translate('payment_received')!,
                          notifMessage: AppLocalizations.of(context)!
                              .translate('payment_received_message')!,
                          page: OrderStatusPage()),
                      _createItem(
                          notifDate: '9 Sep 2019 11:32',
                          notifTitle: AppLocalizations.of(context)!
                              .translate('waiting_for_payment')!,
                          notifMessage: AppLocalizations.of(context)!
                              .translate('waiting_for_payment_message')!,
                          page: OrderStatusPage()),
                      _createItem(
                          notifDate: '9 Sep 2019 11:32',
                          notifTitle: AppLocalizations.of(context)!
                              .translate('order_placed')!,
                          notifMessage: AppLocalizations.of(context)!
                              .translate('order_placed_message')!,
                          page: OrderStatusPage()),
                    ])),
        ));
  }

  Widget _createItem(
      {required String notifDate,
      required String notifTitle,
      required String notifMessage,
      StatefulWidget? page}) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (page != null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => page));
        }
      },
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notifTitle,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: CHARCOAL)),
                    SizedBox(
                      height: 4,
                    ),
                    Text(notifDate,
                        style:
                            TextStyle(color: Colors.grey[400], fontSize: 11)),
                    SizedBox(
                      height: 8,
                    ),
                    Text(notifMessage, style: TextStyle(color: BLACK_GREY)),
                  ],
                )),
            Divider(
              height: 1,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}
