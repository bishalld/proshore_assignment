/*
This is edit profile picture page

include file in reuseable/global_function.dart to call function from GlobalFunction
include file in reuseable/global_widget.dart to call function from GlobalWidget

install plugin in pubspec.yaml
- fluttertoast => to show toast (https://pub.dev/packages/fluttertoast)
- image_picker => to pick image from storage or camera (https://pub.dev/packages/image_picker)
  add this to ios Info.plist
  <key>NSPhotoLibraryUsageDescription</key>
  <string>I need this permission to test upload photo</string>
  <key>NSCameraUsageDescription</key>
  <string>I need this permission to test upload photo</string>
  <key>NSMicrophoneUsageDescription</key>
  <string>I need this permission to test upload photo</string>

- image_cropper => to crop the image after get from storage or camera (https://pub.dev/packages/image_cropper)
  add this to android manifest :
  <activity
    android:name="com.yalantis.ucrop.UCropActivity"
    android:screenOrientation="portrait"
    android:theme="@style/Theme.AppCompat.Light.NoActionBar"/>

- permission_handler => to handle permission such as storage, camera (https://pub.dev/packages/permission_handler)

we add some logic function so if the user press back or done with this pages, cache images will be deleted and not makes the storage full

Don't forget to add all images and sound used in this pages at the pubspec.yaml

*** IMPORTANT NOTES FOR IOS ***
Image Picker will crash if you pick image for a second times, this error only exist on iOS Simulator 14 globaly around the world but not error on the real device
If you want to use iOS Simulator, you need to downgrade and using iOS Simulator 13
Follow this step to downgrade :
1. Xcode > Preferences
2. Select the "Components" tab.
3. Download and select Simulator 13 after the download is finish
4. Press "Check and Install Now".
5. After that, use Simulator 13 instead of simulator 14
 */

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meroshopping_flutter/config/global_style.dart';
import 'package:meroshopping_flutter/config/shared_pref.dart';
import 'package:meroshopping_flutter/ui/account/account.dart';
import 'package:meroshopping_flutter/ui/bottom_navigation_bar.dart';
import 'package:meroshopping_flutter/ui/reuseable/app_localizations.dart';
import 'package:meroshopping_flutter/ui/reuseable/global_function.dart';
import 'package:meroshopping_flutter/ui/reuseable/global_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:meroshopping_flutter/config/constants.dart';

import '../../../repositories/updateprofilerepo/updateprofilerepo.dart';

class EditProfilePicturePage extends StatefulWidget {
  final String name;
  // final String email;
  // final String contact;
  final dynamic photo;
  final int id;
  EditProfilePicturePage(
      {required this.name,
      //required this.email,
      //required this.contact,
      required this.photo,
      required this.id});
  @override
  _EditProfilePicturePageState createState() => _EditProfilePicturePageState();
}

class _EditProfilePicturePageState extends State<EditProfilePicturePage> {
  TextEditingController nameControler = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactControler = TextEditingController();

  // initialize global function
  final _globalFunction = GlobalFunction();
  final _globalWidget = GlobalWidget();

  File? _image;
  final picker = ImagePicker();
  File? _profilePic;

  File? _selectedFile;
  bool _inProcess = false;

  @override
  void initState() {
    print(widget.id);
    nameControler = TextEditingController(text: widget.name);
    //contactControler = TextEditingController(text: widget.contact);
    // emailController = TextEditingController(text: widget.email);
    super.initState();
  }

  _uploadProfilePic() async {
    XFile? img = await picker.pickImage(source: ImageSource.camera);
    if (img != null) {
      _profilePic = File(img.path);
    }
    setState(() {});
  }

  _uploadFromGallery() async {
    XFile? img = await picker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      _profilePic = File(img.path);
    }
    setState(() {});
  }

  // @override
  // void dispose() {
  //   if (_selectedFile != null && _selectedFile!.existsSync()) {
  //     _selectedFile!.deleteSync();
  //   }
  //   _selectedFile = null;
  //   super.dispose();
  // }

  // Future requestPermission(Permission permission) async {
  //   final result = await permission.request();
  //   return result;
  // }

  // void _askPermissionCamera() {
  //   requestPermission(Permission.camera).then(_onStatusRequestedCamera);
  // }

  // void _askPermissionStorage() {
  //   requestPermission(Permission.storage).then(_onStatusRequested);
  // }

  // void _askPermissionPhotos() {
  //   requestPermission(Permission.photos).then(_onStatusRequested);
  // }

  // void _onStatusRequested(status) {
  //   if (status != PermissionStatus.granted) {
  //     if (Platform.isIOS) {
  //       openAppSettings();
  //     } else {
  //       if (status == PermissionStatus.permanentlyDenied) {
  //         openAppSettings();
  //       }
  //     }
  //   } else {
  //     _getImage(ImageSource.gallery);
  //   }
  // }

  // void _onStatusRequestedCamera(status) {
  //   if (status != PermissionStatus.granted) {
  //     if (Platform.isIOS) {
  //       openAppSettings();
  //     } else {
  //       if (status == PermissionStatus.permanentlyDenied) {
  //         openAppSettings();
  //       }
  //     }
  //   } else {
  //     _getImage(ImageSource.camera);
  //   }
  // }

  // void _getImage(ImageSource source) async {
  //   this.setState(() {
  //     _inProcess = true;
  //   });

  //   final pickedFile = await picker.pickImage(source: source);
  //   setState(() {
  //     if (pickedFile != null) {
  //       _profilePic = File(pickedFile.path);
  //     }
  //   });

  //   if (_profilePic != null) {
  //     File? cropped = await ImageCropper.cropImage(
  //         sourcePath: _image!.path,
  //         aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
  //         compressQuality: 100,
  //         maxWidth: 700,
  //         maxHeight: 700,
  //         cropStyle: CropStyle.circle,
  //         compressFormat: ImageCompressFormat.jpg,
  //         androidUiSettings: AndroidUiSettings(
  //           initAspectRatio: CropAspectRatioPreset.original,
  //           toolbarColor: Colors.white,
  //           toolbarTitle:
  //               AppLocalizations.of(context)!.translate('edit_images')!,
  //           statusBarColor: PRIMARY_COLOR,
  //           activeControlsWidgetColor: CHARCOAL,
  //           cropFrameColor: Colors.white,
  //           cropGridColor: Colors.white,
  //           toolbarWidgetColor: CHARCOAL,
  //           backgroundColor: Colors.white,
  //         ));

  //     this.setState(() {
  //       if (cropped != null) {
  //         if (_profilePic != null && _profilePic!.existsSync()) {
  //           _profilePic!.deleteSync();
  //         }
  //         _profilePic = cropped;
  //       }

  //       // delete image camera
  //       if (source.toString() == 'ImageSource.camera' &&
  //           _profilePic!.existsSync()) {
  //         _profilePic!.deleteSync();
  //       }

  //       _profilePic = null;
  //       _inProcess = false;
  //     });
  //   } else {
  //     this.setState(() {
  //       _inProcess = false;
  //     });
  //   }
  // }

  void cropImage() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: GlobalStyle.appBarIconThemeColor,
          ),
          elevation: GlobalStyle.appBarElevation,
          title: Text(
            AppLocalizations.of(context)!.translate('edit_profile_picture')!,
            style: GlobalStyle.appBarTitle,
          ),
          backgroundColor: GlobalStyle.appBarBackgroundColor,
          systemOverlayStyle: GlobalStyle.appBarSystemOverlayStyle,
          bottom: _globalWidget.bottomAppBar(),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 8),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    _getImageWidget(),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.camera_alt,
                                color: BLACK_GREY,
                                size: 40,
                              ),
                              SizedBox(width: 10),
                              Text(AppLocalizations.of(context)!
                                  .translate('camera')!),
                            ],
                          ),
                          onTap: () {
                            _uploadProfilePic();
                          },
                        ),
                        Container(
                          width: 20,
                        ),
                        GestureDetector(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.photo,
                                color: BLACK_GREY,
                                size: 40,
                              ),
                              SizedBox(width: 10),
                              Text(AppLocalizations.of(context)!
                                  .translate('gallery')!),
                            ],
                          ),
                          onTap: () {
                            _uploadFromGallery();
                            // if (Platform.isIOS) {
                            //   _askPermissionPhotos();
                            // } else {
                            // _uploadFromGallery();

                            // }
                          },
                        ),
                        GestureDetector(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.crop,
                                color: BLACK_GREY,
                                size: 40,
                              ),
                              SizedBox(width: 10),
                              Text("Crop"),
                            ],
                          ),
                          onTap: () async {
                            if (_profilePic == null) {
                              EasyLoading.showToast("Please Select New Image");
                            } else {
                              ///
                              File? cropped = await ImageCropper.cropImage(
                                  sourcePath: _profilePic!.path,
                                  aspectRatio:
                                      CropAspectRatio(ratioX: 1, ratioY: 1),
                                  compressQuality: 100,
                                  maxWidth: 700,
                                  maxHeight: 700,
                                  cropStyle: CropStyle.circle,
                                  compressFormat: ImageCompressFormat.jpg,
                                  androidUiSettings: AndroidUiSettings(
                                    initAspectRatio:
                                        CropAspectRatioPreset.original,
                                    toolbarColor: Colors.white,
                                    toolbarTitle: AppLocalizations.of(context)!
                                        .translate('edit_images')!,
                                    statusBarColor: PRIMARY_COLOR,
                                    activeControlsWidgetColor: CHARCOAL,
                                    cropFrameColor: Colors.white,
                                    cropGridColor: Colors.white,
                                    toolbarWidgetColor: CHARCOAL,
                                    backgroundColor: Colors.white,
                                  ));
                              this.setState(() {
                                if (cropped != null) {
                                  if (_profilePic != null &&
                                      _profilePic!.existsSync()) {
                                    _profilePic!.deleteSync();
                                  }
                                  _profilePic = cropped;
                                }
                              });

                              ///
                            }
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFieldwidget(
                          controller: nameControler,
                          labelText: "Name",
                          inputType: TextInputType.name),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 20, right: 20),
                    //   child: TextFieldwidget(
                    //       labelText: "Contact",
                    //       controller: contactControler,
                    //       inputType: TextInputType.number),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(20.0),
                    //   child: TextFieldwidget(
                    //       labelText: "Email",
                    //       controller: emailController,
                    //       inputType: TextInputType.emailAddress),
                    // ),
                    _buttonSave()
                  ],
                ),
              ),
              (_inProcess)
                  ? Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Center(),
            ],
          ),
        ));
  }

//keet this
  Widget _getImageWidget() {
    if (_profilePic != null) {
      return ClipOval(
        child: Image.file(
          _profilePic!,
          width: 250,
          height: 250,
          fit: BoxFit.fill,
        ),
      );
    } else if (widget.photo == null) {
      return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(width: 4, color: Color(0xff00BAF2)),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: Text(
            widget.name.substring(0, 1).toUpperCase() +
                widget.name.substring(1, 2).toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      );
    } else {
      return ClipOval(
        child: Image.network(
          BASE_PROFILE_IMAGE + widget.photo,
          width: 250,
          height: 250,
          fit: BoxFit.fill,
        ),
      );
    }
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
          onPressed: () async {
            EasyLoading.show(status: "Loading");

            var res = await UpdateProfile().profileUpdate(
                nameControler.text,
                // emailController.text,
                // contactControler.text,
                _profilePic?.path,
                widget.id.toString());

            if (res != false) {
              EasyLoading.showSuccess('Profile updated successfully');
            } else {
              EasyLoading.showError('Error Occured');
            }
            Timer(Duration(milliseconds: 500), () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => BottomNavigationBarPage()));
            });
          },
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Text(
              AppLocalizations.of(context)!.translate('save')!,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
          )),
    );
  }
}

class TextFieldwidget extends StatelessWidget {
  final String labelText;
  TextEditingController controller;
  TextInputType inputType;

  TextFieldwidget({
    required this.labelText,
    required this.controller,
    required this.inputType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: inputType, //TextInputType.number,
      controller: controller,
      style: TextStyle(color: CHARCOAL),
      // onChanged: (textValue) {
      //   setState(() {
      //     if (_globalFunction.validateMobileNumber(textValue)) {
      //       _buttonDisabled = false;
      //     } else {
      //       _buttonDisabled = true;
      //     }
      //   });
      // },
      decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFCCCCCC)),
          ),
          labelText: labelText,
          labelStyle: TextStyle(color: BLACK_GREY)),
    );
  }
}
