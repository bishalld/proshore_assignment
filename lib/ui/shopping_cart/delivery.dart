/*
This is delivery page

include file in reuseable/global_function.dart to call function from GlobalFunction
include file in reuseable/global_widget.dart to call function from GlobalWidget
include file in reuseable/cache_image_network.dart to use cache image network
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meroshopping_flutter/bloc/products/checkout/checkoutbloc/checkout_bloc.dart';
import 'package:meroshopping_flutter/config/constants.dart';
import 'package:meroshopping_flutter/config/global_style.dart';
import 'package:meroshopping_flutter/config/shared_pref.dart';
import 'package:meroshopping_flutter/repositories/location/locationrepository.dart';
import 'package:meroshopping_flutter/repositories/shipping%20time/shiptimerepository.dart';
import 'package:meroshopping_flutter/ui/bottom_navigation_bar.dart';
import 'package:meroshopping_flutter/ui/reuseable/app_localizations.dart';
import 'package:meroshopping_flutter/ui/reuseable/cache_image_network.dart';
import 'package:meroshopping_flutter/ui/reuseable/global_function.dart';
import 'package:meroshopping_flutter/ui/reuseable/global_widget.dart';
import 'package:meroshopping_flutter/ui/shopping_cart/payment.dart';

class DeliveryPage extends StatefulWidget {
  final List shoppingCartData;

  const DeliveryPage({Key? key, required this.shoppingCartData})
      : super(key: key);

  @override
  _DeliveryPageState createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  // initialize global function
  final _globalFunction = GlobalFunction();
  final _globalWidget = GlobalWidget();

  List shoppingCartData = [];
  TextEditingController _area = TextEditingController();

  double _subTotal = 0;
  String _delivery = '';
  String _shipTime = '';
  List time = [];
  List cities = [];
  String cityId = "";
  List areas = [];
  List states = [];
  String stateId = "";
  String areaId = "";
  late CheckoutBloc _checkoutBloc;
  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;

  @override
  void initState() {
    print(userToken);
    _checkoutBloc = BlocProvider.of<CheckoutBloc>(context);
    shoppingCartData = widget.shoppingCartData;
    locationData();
    shipTimeData();

    countSubTotal();

    super.initState();
  }

  void locationData() async {
    EasyLoading.show(status: "loading");
    var state = await LocationRepo().state();
    if (state != false) {
      EasyLoading.dismiss();
      states = state.state;
      cities = [];
    }
    setState(() {});
  }

  void shipTimeData() async {
    var timeRes = await ShipTimeRepo().shipTime();
    time = timeRes.time;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void countSubTotal() {
    _subTotal = 0;
    for (int i = 0; i < shoppingCartData.length; i++) {
      _subTotal += shoppingCartData[i].price * shoppingCartData[i].quantity;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double boxImageSize = (MediaQuery.of(context).size.width / 6);
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: GlobalStyle.appBarIconThemeColor,
          ),
          elevation: GlobalStyle.appBarElevation,
          title: Text(
            AppLocalizations.of(context)!.translate('delivery')!,
            style: GlobalStyle.appBarTitle,
          ),
          backgroundColor: GlobalStyle.appBarBackgroundColor,
          systemOverlayStyle: GlobalStyle.appBarSystemOverlayStyle,
          bottom: _globalWidget.bottomAppBar(),
        ),
        body: BlocListener<CheckoutBloc, CheckoutState>(
          listener: (context, state) {
            if (state is CheckoutWaiting) {
              EasyLoading.show(status: "loading");
            }
            if (state is CheckoutError) {
              Container(
                  child: Center(
                      child: Text(ERROR_OCCURED,
                          style: TextStyle(fontSize: 14, color: BLACK_GREY))));
            }
            if (state is CheckoutSuccess) {
              print(state.message);
              EasyLoading.dismiss();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PaymentPage(
                            totalPrice: _subTotal,
                            tempId: state.tempId,
                          )));
            }
          },
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                // _createDeliveryInformation(),
                _createOrderListInformation(boxImageSize),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16),
                  child: Text("Choose Delivery Address",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "State",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 0.4), //(x,y)
                                  blurRadius: 1.0,
                                ),
                              ],
                            ),
                            child: ListTile(
                              title: SizedBox(
                                height: 40,
                                child: states.isNotEmpty
                                    ? DropdownButtonHideUnderline(
                                        child: DropdownButtonFormField<dynamic>(
                                          validator: (value) => value == null
                                              ? 'field required'
                                              : null,
                                          hint: Text("Select State"),
                                          decoration: InputDecoration(
                                              border: InputBorder.none),
                                          items: states.map((data) {
                                            return DropdownMenuItem<dynamic>(
                                              value: data.id.toString(),
                                              child: Text(data.cities),
                                            );
                                          }).toList(),
                                          onChanged: (value) async {
                                            stateId = value;
                                            var city = await LocationRepo()
                                                .city(stateId);

                                            cities = city.city;
                                            setState(() {});
                                          },
                                          onTap: () {
                                            setState(() {
                                              cities.clear();
                                              areas.clear();
                                            });
                                          },
                                        ),
                                      )
                                    : Container(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "City",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 0.4), //(x,y)
                                  blurRadius: 1.0,
                                ),
                              ],
                            ),
                            child: ListTile(
                              title: SizedBox(
                                height: 45,
                                child: cities.isNotEmpty
                                    ? DropdownButtonHideUnderline(
                                        child: DropdownButtonFormField<dynamic>(
                                          hint: Text("Select city"),
                                          validator: (value) => value == null
                                              ? 'field required'
                                              : null,
                                          decoration: InputDecoration(
                                              border: InputBorder.none),
                                          items: cities.map((data) {
                                            return DropdownMenuItem<dynamic>(
                                              value: data.id.toString(),
                                              child: Text(data.cityName),
                                            );
                                          }).toList(),
                                          onChanged: (value) async {
                                            cityId = value;
                                            var area = await LocationRepo()
                                                .area(cityId);
                                            areas = area.area;
                                            setState(() {});
                                          },
                                          onTap: () {
                                            setState(() {
                                              areas.clear();
                                            });
                                          },
                                        ),
                                      )
                                    : Container(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Area",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 0.4), //(x,y)
                                  blurRadius: 1.0,
                                ),
                              ],
                            ),
                            child: ListTile(
                              title: SizedBox(
                                height: 45,
                                child: areas.isNotEmpty
                                    ? DropdownButtonHideUnderline(
                                        child: DropdownButtonFormField<dynamic>(
                                          hint: Text("Select area"),
                                          decoration: InputDecoration(
                                              border: InputBorder.none),
                                          items: areas.map((value) {
                                            return DropdownMenuItem<dynamic>(
                                              value: value.id.toString(),
                                              child: Text(value.areaName != []
                                                  ? value.areaName
                                                  : "No area found for this city"),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            areaId = value;
                                          },
                                        ),
                                      )
                                    : TextFormField(
                                        controller: _area,
                                        validator: (value) {
                                          if (value == null) {
                                            return 'This field is required';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          areaId = _area.text;
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Enter area",
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _createChooseShipTimeInformation(),
                _createSubTotalInformation()
              ],
            ),
          ),
        ));
  }

  Widget _createOrderListInformation(boxImageSize) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.translate('order_list')!,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Column(
            children: List.generate(shoppingCartData.length, (index) {
              int quantity = shoppingCartData[index].quantity;
              return GestureDetector(
                onTap: () {
                  //Navigator.push(
                  // context,
                  //MaterialPageRoute(
                  // builder: (context) => ProductDetailPage(
                  //       urlName: shoppingCartData[index].name,
                  //     )));
                },
                child: Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          child: buildCacheNetworkImage(
                              width: boxImageSize,
                              height: boxImageSize,
                              url:
                                  "$BASE_IMAGE_URL${shoppingCartData[index].filename}")),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              shoppingCartData[index].product,
                              style: GlobalStyle.productName.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 4),
                                child: Text(
                                    quantity.toString() +
                                        ' ' +
                                        AppLocalizations.of(context)!
                                            .translate('item')! +
                                        ' (150 ' +
                                        AppLocalizations.of(context)!
                                            .translate('gr')! +
                                        ')',
                                    style: GlobalStyle.shoppingCartOtherProduct
                                        .copyWith(color: Colors.grey[400]))),
                            Container(
                              margin: EdgeInsets.only(top: 4),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  ///
  Widget _createChooseShipTimeInformation() {
    return Container(
        margin: EdgeInsets.only(top: 6),
        padding: EdgeInsets.symmetric(horizontal: 16),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(" Shipment Time",
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
                    return _showShipTimePopup();
                  },
                );
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1, color: Colors.grey[300]!),
                    borderRadius: BorderRadius.all(
                        Radius.circular(10) //         <--- border radius here
                        )),
                child: _shipTime == ''
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.local_shipping, color: Colors.green),
                              SizedBox(width: 12),
                              Text("Choose Shipment Time",
                                  style: TextStyle(
                                      color: CHARCOAL,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Icon(Icons.chevron_right, size: 20, color: SOFT_GREY),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_shipTime,
                                  style: TextStyle(
                                      color: CHARCOAL,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                          Icon(Icons.chevron_right, size: 20, color: SOFT_GREY),
                        ],
                      ),
              ),
            ),
          ],
        ));
  }

  ///
  ///

  Widget _showShipTimePopup() {
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
            child:
                Text("Choose Shipment Time:", style: GlobalStyle.chooseCourier),
          ),
          Flexible(
            child: ListView(
              padding: EdgeInsets.all(10),
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      _shipTime = "${time[0].timeSchedule1} AM";
                    });
                    countSubTotal();
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 16),
                    child: Text("${time[0].timeSchedule1} AM",
                        style: GlobalStyle.sectionTitle),
                  ),
                ),
                Divider(
                  color: Colors.grey[800],
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    print(_shipTime);
                    setState(() {
                      _shipTime = "${time[0].timeSchedule2} AM";
                    });
                    countSubTotal();
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 16),
                    child: Text("${time[0].timeSchedule2} AM",
                        style: GlobalStyle.sectionTitle),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  ///
  ///

  Widget _createSubTotalInformation() {
    return Container(
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context)!.translate('sub_total')! + ' ',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text('\Rs ' + _globalFunction.removeDecimalZeroFormat(_subTotal),
                  style: GlobalStyle.shoppingCartTotalPrice),
            ],
          ),
          TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) => PRIMARY_COLOR,
                ),
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                )),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _checkoutBloc.add(PostCheckoutDataEvent(
                      amount: _subTotal.toString(),
                      city: cityId,
                      cityArea: areaId,
                      comments: "",
                      deliveryCharge: "100",
                      discount: "10",
                      shippingTime: _shipTime, //.isEmpty ? "9:00" : _shipTime,
                      state: stateId,
                      totalAmount: _subTotal.toString()));
                } else {
                  EasyLoading.showError("Please fill the necessary fields");
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "CheckOut",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ))
        ],
      ),
    );
  }
}
