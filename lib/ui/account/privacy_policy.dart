/*
This is privacy policy page

include file in reuseable/global_widget.dart to call function from GlobalWidget

install plugin in pubspec.yaml
- flutter_html => to show toast (https://pub.dev/packages/flutter_html)

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:meroshopping_flutter/config/constants.dart';
import 'package:meroshopping_flutter/config/global_style.dart';
import 'package:meroshopping_flutter/ui/reuseable/app_localizations.dart';
import 'package:meroshopping_flutter/ui/reuseable/global_widget.dart';

class PrivacyPolicyPage extends StatefulWidget {
  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  // initialize global widget
  final _globalWidget = GlobalWidget();

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
            AppLocalizations.of(context)!.translate('privacy_policy')!,
            style: GlobalStyle.appBarTitle,
          ),
          backgroundColor: GlobalStyle.appBarBackgroundColor,
          systemOverlayStyle: GlobalStyle.appBarSystemOverlayStyle,
          bottom: _globalWidget.bottomAppBar(),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "privacy policy",
                    style: GlobalStyle.heading,
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  Text(
                      "Privacy Policy helps you to know how meroshopping.com collects, uses and protects the personal information that you provide on our site. We consider the information of our clients with utmost discreet. All of the information that you provide (including customer account, transactions and other correspondence) will be handled with maximum protection.",
                      textAlign: TextAlign.left),
                  SizedBox(
                    height: 20,
                  ),

                  ////
                  ///
                  ///
                  Text(
                    "Collection of Personal Information",
                    style: GlobalStyle.heading,
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  Text(
                      "No personal information will be collected when you simply browse our site. Some of our functions and services (like ordering a product or getting registered with us) may need your postal address, e-mail address etc.) Under such case, the only personal information collected by our website www.meroshopping.com will be the information that is willingly provided to us by site visitors.The collected Personal information will be:"),
                  Text(
                    "1. Your name and address \n2. Contact information including email address, phone number and cell number\n3. Ut enim ad minim veniam, quis nostrud exercitation \n4. Name, address and contact details of the person to whom the goods are to be delivered",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  ///
                  ///
                  ///
                  Text(
                    "Why do we require the information? What do we do with the collected information?",
                    style: GlobalStyle.heading,
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),

                  Text(
                    "1. To confirm the validity of the order placed\n2. To accurately identify the delivery address\n3. Internal Record Keeping\n4. We may use information to improve our products and services\n5. We may periodically send promotional emails about new products, special offers and other matters of similar interest in your email address that you might find useful\n6. We may also use the information to contact you for feedback response so that we can optimize our site and become more useful to our clients.\n7. Meroshopping.com will not share e-mail addresses and postal addresses that we collect in our site with any unaffiliated third parties.",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  ///
                  ///
                  Text(
                    "Searches",
                    style: GlobalStyle.heading,
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  Text(
                      "We do not collect your name or email address when you simply use our ‘Search Product’ feature. We may keep logs of all words searched to help us to know what the clients are looking for",
                      textAlign: TextAlign.left),
                  SizedBox(
                    height: 20,
                  ),

                  ///
                  ///
                  Text(
                    "How we use cookies?",
                    style: GlobalStyle.heading,
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  Text(
                      "We use traffic log cookies to know about the pages that are being used. Cookies help us to analyze our web page traffic and improve our website according to the need of our customers. The data will immediately be removed from the system as soon as we analyze the data.",
                      textAlign: TextAlign.left),
                  SizedBox(
                    height: 20,
                  ),

                  ///
                  ///
                  Text(
                    "Links to other websites",
                    style: GlobalStyle.heading,
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  Text(
                      "Meroshopping.com may contain links to other websites. We will not have control over that other website when you use the given link to leave our website. So, we cannot be hold responsible for protection and privacy of information that you provide while visiting those other sites through the link.",
                      textAlign: TextAlign.left),
                  SizedBox(
                    height: 20,
                  ),

                  ///
                  ///
                  Text(
                    "Credit Card",
                    style: GlobalStyle.heading,
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  Text(
                      "We use credit card numbers that are submitted to us through our website for payment purposes only and not for marketing purposes. Our transactions are processed within secure server that uses secure encryption technology to assure privacy and security of credit card numbers of anyone who places online orders with us. Please email us at info@meroshopping.com immediately if you think the information that we are holding on you is incorrect or incomplete so that we can correct the information that are found to be incorrect.",
                      textAlign: TextAlign.left),
                  SizedBox(
                    height: 20,
                  ),
                ],
              )),
        ));
  }
}
