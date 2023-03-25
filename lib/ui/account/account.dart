import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meroshopping_flutter/bloc/account/accountinfo/bloc/account_bloc.dart';
import 'package:meroshopping_flutter/config/constants.dart';
import 'package:meroshopping_flutter/config/global_style.dart';
import 'package:meroshopping_flutter/config/shared_pref.dart';
import 'package:meroshopping_flutter/ui/account/about.dart';
import 'package:meroshopping_flutter/ui/account/account_information/account_information.dart';
import 'package:meroshopping_flutter/ui/account/notification_setting.dart';
import 'package:meroshopping_flutter/ui/account/privacy_policy.dart';
import 'package:meroshopping_flutter/ui/account/order/order_list.dart';
import 'package:meroshopping_flutter/ui/authentication/signin/signin.dart';
import 'package:meroshopping_flutter/ui/general/notification.dart';
import 'package:meroshopping_flutter/ui/reuseable/app_localizations.dart';
import 'package:meroshopping_flutter/ui/reuseable/cache_image_network.dart';
import 'package:meroshopping_flutter/ui/account/terms_conditions.dart';
import 'package:meroshopping_flutter/ui/reuseable/global_widget.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
// with AutomaticKeepAliveClientMixin
{
  // initialize global widget
  final _globalWidget = GlobalWidget();
  var accountData;
  late AccountBloc _accountBloc;

  // @override
  // bool get wantKeepAlive => true;

  @override
  void initState() {
    _accountBloc = BlocProvider.of<AccountBloc>(context);
    _accountBloc.add(AccountInfoEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if we used AutomaticKeepAliveClientMixin, we must call super.build(context);
    // super.build(context);
    return Scaffold(
        appBar: AppBar(
          elevation: GlobalStyle.appBarElevation,
          title: Text(
            AppLocalizations.of(context)!.translate('account')!,
            style: GlobalStyle.appBarTitle,
          ),
          backgroundColor: GlobalStyle.appBarBackgroundColor,
          systemOverlayStyle: GlobalStyle.appBarSystemOverlayStyle,
          actions: [
            // GestureDetector(
            //     onTap: () {
            //       Navigator.push(context,
            //           MaterialPageRoute(builder: (context) => ChatUsPage()));
            //     },
            //     child: Icon(Icons.email, color: BLACK_GREY)),

            // IconButton(
            //     icon: _globalWidget.customNotifIcon(8, BLACK_GREY),
            //     onPressed: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => NotificationPage()));
            //     }),
          ],
          bottom: _globalWidget.bottomAppBar(),
        ),
        body: BlocListener<AccountBloc, AccountState>(
          listener: (context, state) {
            if (state is AccountFetcWaiting) {
              EasyLoading.show(status: "Loading");
            } else if (state is AccountFetchErrorState) {
              Text("Error Fetching Data");
            } else if (state is AccountFetchSuccessState) {
              accountData = state.accountData;
              //  print(accountData);
              EasyLoading.dismiss();
            }
          },
          child:
              BlocBuilder<AccountBloc, AccountState>(builder: (context, state) {
            return ListView(
              padding: EdgeInsets.all(16),
              children: [
                accountData == null
                    ? Container(
                        height: 200,
                      )
                    : _createAccountInformation(),

                _createListMenu(
                    AppLocalizations.of(context)!.translate('order_list')!,
                    OrderPage()),
                Divider(height: 15, color: Colors.grey[400], thickness: 1),
                // _createListMenu(
                //     AppLocalizations.of(context)!
                //         .translate('review_product')!,
                //     ListInvoicesPage()
                //     ),

                // _createListMenu(
                //     AppLocalizations.of(context)!
                //         .translate('notification_setting')!,
                //     NotificationSettingPage()),

                // Divider(height: 15, color: Colors.grey[400], thickness: 1),

                _createListMenu(
                    AppLocalizations.of(context)!.translate('about')!,
                    AboutPage()),
                Divider(height: 15, color: Colors.grey[400], thickness: 1),
                _createListMenu(
                    AppLocalizations.of(context)!
                        .translate('terms_conditions')!,
                    TermsConditionsPage()),
                Divider(height: 15, color: Colors.grey[400], thickness: 1),
                // _createListMenu(
                //     AppLocalizations.of(context)!.translate('privacy_policy')!,
                //     PrivacyPolicyPage()),
                // Divider(height: 15, color: Colors.grey[400], thickness: 1),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 18, 0, 0),
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      HelperClass().removeuserToken();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SigninPage()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.power_settings_new,
                            size: 20, color: ASSENT_COLOR),
                        SizedBox(width: 8),
                        Text(
                            AppLocalizations.of(context)!
                                .translate('sign_out')!,
                            style:
                                TextStyle(fontSize: 15, color: ASSENT_COLOR)),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ));
  }

  Widget _createAccountInformation() {
    final double profilePictureSize = MediaQuery.of(context).size.width / 4;
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(bottom: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: profilePictureSize,
                height: profilePictureSize,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AccountInformationPage()));
                  },
                  child: accountData.photo == null
                      ? CircleAvatar(
                          backgroundColor: Colors.grey[200],
                          radius: profilePictureSize,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: profilePictureSize - 4,
                            child: Hero(
                              tag: 'profilePicture',
                              child: ClipOval(
                                  child: buildCacheNetworkImage(
                                      width: profilePictureSize - 4,
                                      height: profilePictureSize - 4,
                                      url:
                                          BASE_IMAGE_URL + '/user/avatar.png')),

                              ///image remaining to set
                            ),
                          ),
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: profilePictureSize - 4,
                          child: Hero(
                            tag: 'profilePicture',
                            child: ClipOval(
                                child: buildCacheNetworkImage(
                                    width: profilePictureSize - 4,
                                    height: profilePictureSize - 4,
                                    url: BASE_PROFILE_IMAGE +
                                        accountData.photo)),

                            ///image remaining to set
                          ),
                        ),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(accountData.name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AccountInformationPage()));
                      },
                      child: Row(
                        children: [
                          Text(
                              AppLocalizations.of(context)!
                                  .translate('account_information')!,
                              style:
                                  TextStyle(fontSize: 14, color: BLACK_GREY)),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(Icons.chevron_right, size: 20, color: SOFT_GREY)
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _createListMenu(String menuTitle, StatefulWidget page) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 18, 0, 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(menuTitle, style: TextStyle(fontSize: 15, color: CHARCOAL)),
            Icon(Icons.chevron_right, size: 20, color: SOFT_GREY),
          ],
        ),
      ),
    );
  }
}
