/*
This is notification setting page
include file in reuseable/global_widget.dart to call function from GlobalWidget
 */

import 'package:flutter/material.dart';
import 'package:meroshopping_flutter/config/constants.dart';
import 'package:meroshopping_flutter/config/global_style.dart';
import 'package:meroshopping_flutter/ui/reuseable/app_localizations.dart';
import 'package:meroshopping_flutter/ui/reuseable/global_widget.dart';

class NotificationSettingPage extends StatefulWidget {
  @override
  _NotificationSettingPageState createState() =>
      _NotificationSettingPageState();
}

class _NotificationSettingPageState extends State<NotificationSettingPage> {
  final _globalWidget = GlobalWidget();

  bool _valChat = true;
  bool _valPromotion = true;
  bool _valOrderStatus = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
            AppLocalizations.of(context)!.translate('notification_setting')!,
            style: GlobalStyle.appBarTitle,
          ),
          backgroundColor: GlobalStyle.appBarBackgroundColor,
          systemOverlayStyle: GlobalStyle.appBarSystemOverlayStyle,
          bottom: _globalWidget.bottomAppBar(),
        ),
        body: ListView(
          children: [
            _buildSwitchPromotion(),
            Divider(height: 0, color: Colors.grey[400]),
            _buildSwitchChat(),
            Divider(height: 0, color: Colors.grey[400]),
            _buildSwitchOrderStatus(),
            Divider(height: 0, color: Colors.grey[400]),
          ],
        ));
  }

  Widget _buildSwitchPromotion() {
    return SwitchListTile(
      contentPadding: EdgeInsets.only(left: 16, right: 4),
      title: Text(
        AppLocalizations.of(context)!.translate('promotion')!,
        style: TextStyle(fontSize: 15, color: CHARCOAL),
      ),
      value: _valPromotion,
      activeColor: PRIMARY_COLOR,
      onChanged: (bool value) {
        setState(() {
          _valPromotion = value;
        });
      },
    );
  }

  Widget _buildSwitchChat() {
    return SwitchListTile(
      contentPadding: EdgeInsets.only(left: 16, right: 4),
      title: Text(
        AppLocalizations.of(context)!.translate('chat')!,
        style: TextStyle(fontSize: 15, color: CHARCOAL),
      ),
      value: _valChat,
      activeColor: PRIMARY_COLOR,
      onChanged: (bool value) {
        setState(() {
          _valChat = value;
        });
      },
    );
  }

  Widget _buildSwitchOrderStatus() {
    return SwitchListTile(
      contentPadding: EdgeInsets.only(left: 16, right: 4),
      title: Text(
        AppLocalizations.of(context)!.translate('new_order_status')!,
        style: TextStyle(fontSize: 15, color: CHARCOAL),
      ),
      value: _valOrderStatus,
      activeColor: PRIMARY_COLOR,
      onChanged: (bool value) {
        setState(() {
          _valOrderStatus = value;
        });
      },
    );
  }
}
