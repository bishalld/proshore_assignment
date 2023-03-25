/*
This is about page

include file in reuseable/global_widget.dart to call function from GlobalWidget

install plugin in pubspec.yaml
- package_info (https://pub.dev/packages/package_info)

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'package:flutter/material.dart';
import 'package:meroshopping_flutter/config/constants.dart';
import 'package:meroshopping_flutter/config/global_style.dart';
import 'package:meroshopping_flutter/ui/reuseable/app_localizations.dart';
import 'package:meroshopping_flutter/ui/reuseable/global_widget.dart';
import 'package:package_info/package_info.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final _globalWidget = GlobalWidget();

  String _version = '1.0.0';

  Future<void> _getSystemDevice() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _version = packageInfo.version;
    });
  }

  @override
  void initState() {
    _getSystemDevice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MERO_SHOPPING_ICON_COLOR,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: GlobalStyle.appBarIconThemeColor,
          ),
          elevation: GlobalStyle.appBarElevation,
          title: Text(
            AppLocalizations.of(context)!.translate('about')!,
            style: GlobalStyle.appBarTitle,
          ),
          backgroundColor: GlobalStyle.appBarBackgroundColor,
          systemOverlayStyle: GlobalStyle.appBarSystemOverlayStyle,
          bottom: _globalWidget.bottomAppBar(),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                  child: Image.asset('assets/icons/mero_shoppinglogo.png',
                      height: 100)),
              SizedBox(
                height: 50,
              ),
              Text(
                AppLocalizations.of(context)!.translate('app_version')!,
                style: TextStyle(fontSize: 14, color: CHARCOAL),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                _version,
                style: TextStyle(fontSize: 14, color: CHARCOAL),
              ),
            ],
          ),
        ));
  }
}
