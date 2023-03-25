/*
This is account information page

include file in reuseable/global_function.dart to call function from GlobalFunction
include file in reuseable/global_widget.dart to call function from GlobalWidget
include file in reuseable/cache_image_network.dart to use cache image network
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meroshopping_flutter/bloc/account/accountinfo/bloc/account_bloc.dart';
import 'package:meroshopping_flutter/config/constants.dart';
import 'package:meroshopping_flutter/config/global_style.dart';
import 'package:meroshopping_flutter/ui/account/account_information/edit_profile_picture.dart';
import 'package:meroshopping_flutter/ui/reuseable/app_localizations.dart';
import 'package:meroshopping_flutter/ui/reuseable/cache_image_network.dart';
import 'package:meroshopping_flutter/ui/reuseable/global_widget.dart';

class AccountInformationPage extends StatefulWidget {
  @override
  _AccountInformationPageState createState() => _AccountInformationPageState();
}

class _AccountInformationPageState extends State<AccountInformationPage> {
  // initialize global widget
  final _globalWidget = GlobalWidget();
  var accountData;
  bool _lastaccountData = false;
  late AccountBloc _accountBloc;

  @override
  void initState() {
    _accountBloc = BlocProvider.of<AccountBloc>(context);
    _accountBloc.add(AccountInfoEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountBloc, AccountState>(
      listener: (context, state) {
        if (state is AccountFetchErrorState) {
          Text("Error Fetching Data");
        } else if (state is AccountFetcWaiting) {
          EasyLoading.show(status: "Loading");
        } else if (state is AccountFetchSuccessState) {
          accountData = state.accountData;
          EasyLoading.dismiss();
        }
        // TODO: implement listener
      },
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: GlobalStyle.appBarIconThemeColor,
            ),
            elevation: GlobalStyle.appBarElevation,
            title: Text(
              AppLocalizations.of(context)!.translate('account_information')!,
              style: GlobalStyle.appBarTitle,
            ),
            backgroundColor: GlobalStyle.appBarBackgroundColor,
            systemOverlayStyle: GlobalStyle.appBarSystemOverlayStyle,
            bottom: _globalWidget.bottomAppBar(),
          ),
          body: BlocBuilder<AccountBloc, AccountState>(
            builder: (context, state) {
              return accountData == null
                  ? Container()
                  : Container(
                      margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _createProfilePicture(),
                          SizedBox(height: 40),
                          Text(
                            AppLocalizations.of(context)!.translate('name')!,
                            style: GlobalStyle.accountInformationLabel,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  accountData.name,
                                  style: GlobalStyle.accountInformationValue,
                                ),
                              ),
                              // GestureDetector(
                              //   onTap: () {
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) => EditNamePage(
                              //                 name: accountData.name,
                              //                 email: accountData.email,
                              //                 contact: accountData.contact,
                              //                 imageUrl: accountData.photo

                              //                 ///photo is null
                              //                 )));
                              //   },
                              //   child: Text(
                              //       AppLocalizations.of(context)!
                              //           .translate('edit')!,
                              //       style: GlobalStyle.accountInformationEdit),
                              // )
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!
                                    .translate('email')!,
                                style: GlobalStyle.accountInformationLabel,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              _verifiedLabel()
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  accountData.email,
                                  style: GlobalStyle.accountInformationValue,
                                ),
                              ),
                              // GestureDetector(
                              //   onTap: () {
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) => EditEmailPage(
                              //                   email: accountData.email,
                              //                 )));
                              //   },
                              //   child: Text(
                              //       AppLocalizations.of(context)!
                              //           .translate('edit')!,
                              //       style: GlobalStyle.accountInformationEdit),
                              // )
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!
                                    .translate('phone_number')!,
                                style: GlobalStyle.accountInformationLabel,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              _verifiedLabel()
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  accountData.contact == null
                                      ? ""
                                      : accountData.contact,
                                  style: GlobalStyle.accountInformationValue,
                                ),
                              ),
                              // GestureDetector(
                              //   onTap: () {
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) =>
                              //                 EditPhoneNumberPage(
                              //                   phoneNumber:
                              //                       accountData.contact,
                              //                 )));
                              //   },
                              //   child: Text(
                              //       AppLocalizations.of(context)!
                              //           .translate('edit')!,
                              //       style: GlobalStyle.accountInformationEdit),
                              // )
                            ],
                          ),
                          Center(child: _buttonSave()),
                        ],
                      ));
            },
          )),
    );
  }

  Widget _createProfilePicture() {
    final double profilePictureSize = MediaQuery.of(context).size.width / 3;
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.only(top: 40),
        width: profilePictureSize,
        height: profilePictureSize,
        child: GestureDetector(
          onTap: () {
            _showPopupUpdatePicture();
          },
          child: Stack(
            children: [
              accountData.photo == null
                  ? CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: (profilePictureSize),
                      child: Hero(
                        tag: 'profilePicture',
                        child: ClipOval(
                            child: buildCacheNetworkImage(
                                width: profilePictureSize,
                                height: profilePictureSize,
                                url: BASE_IMAGE_URL + '/user/avatar.png')),
                      ),
                    )
                  : CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: (profilePictureSize),
                      child: Hero(
                        tag: 'profilePicture',
                        child: ClipOval(
                            child: buildCacheNetworkImage(
                                width: profilePictureSize,
                                height: profilePictureSize,
                                url:
                                    "$BASE_PROFILE_IMAGE${accountData.photo}")),
                      ),
                    ),
              // create edit icon in the picture
              // Container(
              //   width: 30,
              //   height: 30,
              //   margin: EdgeInsets.only(
              //       top: 0, left: MediaQuery.of(context).size.width / 4),
              //   child: Card(
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(30),
              //     ),
              //     elevation: 1,
              //     child: Icon(Icons.edit, size: 12, color: CHARCOAL),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _verifiedLabel() {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
      decoration: BoxDecoration(
          color: SOFT_BLUE, borderRadius: BorderRadius.circular(2)),
      child: Row(
        children: [
          Text(AppLocalizations.of(context)!.translate('verified')!,
              style: TextStyle(color: Colors.white, fontSize: 11)),
          SizedBox(
            width: 4,
          ),
          Icon(Icons.done, color: Colors.white, size: 11)
        ],
      ),
    );
  }

  Widget _buttonSave() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) => PRIMARY_COLOR,
            ),
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            )),
          ),
          onPressed: () {
            _showPopupUpdatePicture();
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => EditProfilePage(
            //               name: accountData.name,
            //               email: accountData.email,
            //               contact: accountData.contact,
            //               photo: accountData.photo,
            //             )));
          },
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Text(
              AppLocalizations.of(context)!.translate('edit')!,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
          )),
    );
  }

  void _showPopupUpdatePicture() {
    // set up the buttons
    Widget cancelButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(AppLocalizations.of(context)!.translate('no')!,
            style: TextStyle(color: SOFT_BLUE)));
    Widget continueButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditProfilePicturePage(
                        name: accountData.name,
                        //email: accountData.email,
                        //contact: accountData.contact,
                        photo: accountData.photo,
                        id: accountData.id,
                      )));
        },
        child: Text(AppLocalizations.of(context)!.translate('yes')!,
            style: TextStyle(color: SOFT_BLUE)));

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        "Edi Profile",
        style: TextStyle(fontSize: 18),
      ),
      content: Text("Do you want to edit your profile ?",
          style: TextStyle(fontSize: 13, color: BLACK_GREY)),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
